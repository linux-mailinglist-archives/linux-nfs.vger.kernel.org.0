Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C2D2EADC9
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Jan 2021 16:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbhAEO62 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Jan 2021 09:58:28 -0500
Received: from p3plsmtpa08-02.prod.phx3.secureserver.net ([173.201.193.103]:35125
        "EHLO p3plsmtpa08-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725862AbhAEO61 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 5 Jan 2021 09:58:27 -0500
X-Greylist: delayed 528 seconds by postgrey-1.27 at vger.kernel.org; Tue, 05 Jan 2021 09:58:27 EST
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id wndlk7fm2Goiawndlk52cS; Tue, 05 Jan 2021 07:48:54 -0700
X-CMAE-Analysis: v=2.4 cv=SvJVVNC0 c=1 sm=1 tr=0 ts=5ff47c56
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=hpq3dx3UihE8fCEceWMA:9 a=q_WKLyjDcRPOdKFa:21
 a=6WrFwjtl4syCEMyO:21 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v2] systemd: rpc-statd-notify.service can run in the
 background
To:     Hackintosh 5 <hackintoshfive@gmail.com>, linux-nfs@vger.kernel.org
Cc:     Hackintosh 5 <git@hack5.dev>
References: <A5C09F1B-9309-40AC-99E6-BADA5CAD6CED@oracle.com>
 <20210104185500.4018-1-git@hack5.dev>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <dfd19b53-b774-989d-43ef-adee5bf71c42@talpey.com>
Date:   Tue, 5 Jan 2021 09:48:54 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20210104185500.4018-1-git@hack5.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfNcumSPoSiYruaLzZWV6ABwK0cA8VSsnjDrLWD4/70uXzL1B7kE8ceD5ouvhZ5plMnUJ3EzsKJ8EUKHZNryVRCd5geOFbOv5UI524Rj1jYZzrNWNxaGF
 XvLJFvqfU9uR4LtJjOjoQGubJ3iWmIqocngM0EOTpkBZ8ACwfT48F7lAmx+s6UuXVBjqHEGBAKxa7Ic74PArplrS9ZBYSjUtKnHc8SHIiy3xJMNNzdjcpQIc
 nck3MWEBExr2W7iKmtauTQ==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 1/4/2021 1:55 PM, Hackintosh 5 wrote:
> This allows rpc-statd-notify to run in the background when it is
> only in use by a client. This is done by a timer unit with a one
> second timeout, which is Wanted by nfs-client.target. The result
> is that there is no longer a dependency on network-online.target
> by multi-user.target, so everyone gets faster boot times yay.

I'm concerned that this change may allow the nfs client to start
before the sm-notify has a chance to send its "I'm back" message
to the server, and for the server to process it. This will lead
to lock failures.

Also, I'm unclear how an apparently arbitrary 1-second delay is
fixing this. Is this really a systemd thing? If so, changing the
NFS behavior is the wrong approach.

Tom.

> ---
>   systemd/nfs-client.target      | 2 +-
>   systemd/rpc-statd-notify.timer | 9 +++++++++
>   2 files changed, 10 insertions(+), 1 deletion(-)
>   create mode 100644 systemd/rpc-statd-notify.timer
> 
> diff --git a/systemd/nfs-client.target b/systemd/nfs-client.target
> index 8a8300a1..b7cce746 100644
> --- a/systemd/nfs-client.target
> +++ b/systemd/nfs-client.target
> @@ -5,7 +5,7 @@ Wants=remote-fs-pre.target
>   
>   # Note: we don't "Wants=rpc-statd.service" as "mount.nfs" will arrange to
>   # start that on demand if needed.
> -Wants=rpc-statd-notify.service
> +Wants=rpc-statd-notify.timer
>   
>   # GSS services dependencies and ordering
>   Wants=auth-rpcgss-module.service
> diff --git a/systemd/rpc-statd-notify.timer b/systemd/rpc-statd-notify.timer
> new file mode 100644
> index 00000000..bac68817
> --- /dev/null
> +++ b/systemd/rpc-statd-notify.timer
> @@ -0,0 +1,9 @@
> +[Unit]
> +Description=Notify NFS peers of a restart
> +RefuseManualStart=true
> +RefuseManualStop=true
> +
> +[Timer]
> +OnActiveSec=1
> +Unit=rpc-statd-notify.service
> +RemainAfterElapse=false
> 
