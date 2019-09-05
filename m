Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1DD3AA1A0
	for <lists+linux-nfs@lfdr.de>; Thu,  5 Sep 2019 13:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbfIELh1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 5 Sep 2019 07:37:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55356 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731633AbfIELh1 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 5 Sep 2019 07:37:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A7F402E97D5;
        Thu,  5 Sep 2019 11:37:26 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-116-147.phx2.redhat.com [10.3.116.147])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 44E035D9CA;
        Thu,  5 Sep 2019 11:37:26 +0000 (UTC)
Subject: Re: [PATCH 1/1] nfsd: Adjust nfs.conf setting/parsing of rdma port
To:     Yongcheng Yang <yongcheng.yang@gmail.com>
Cc:     linux-nfs@vger.kernel.org
References: <20190830092058.18021-1-yongcheng.yang@gmail.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <ad0c81b0-bf92-a88a-4364-42d7ad22fb5f@RedHat.com>
Date:   Thu, 5 Sep 2019 07:37:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190830092058.18021-1-yongcheng.yang@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Thu, 05 Sep 2019 11:37:26 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 8/30/19 5:20 AM, Yongcheng Yang wrote:
> The rpc.nfsd program can use option "--rdma" to enable
> RDMA on the standard port (nfsrdma/20049) or "--rdma=port"
> for an alternate port.
> 
> But now in /etc/nfs.conf, we need to specify the port
> number (e.g. rdma=nfsrdma) to enable it, which is not
> convenient.
> The default setting "rdma=n" may cause more confusion.
> 
> Update to enable RDMA on standard port when setting
> boolean YES to "rdma=". And using "rdma-port=" for an
> alternate port if necessary.
> 
> Also let previous config (e.g. rdma=nfsrdma) work as well.
> 
> Signed-off-by: Yongcheng Yang <yongcheng.yang@gmail.com>
Committed.... 

steved.

> ---
> Hello SteveD,
> 
> I did some simple test:
> ~~~~~~~~~~~~~~~~~~~~~~~
> [root@ rpc-nfsd]# cp rpc.nfsd.new /usr/sbin/rpc.nfsd
> cp: overwrite '/usr/sbin/rpc.nfsd'? y
> [root@ rpc-nfsd]# vi /etc/nfs.conf
> [root@ rpc-nfsd]# cat /etc/nfs.conf
> [nfsd]
> rdma=nfsrdma      <<<<<<<<< previous pattern
> [root@ rpc-nfsd]# systemctl restart nfs-server && cat /proc/fs/nfsd/portlist | grep -w rdma
> [nfsd]
> rdma 20049
> rdma 20049
> [root@ rpc-nfsd]# vi /etc/nfs.conf
> [root@ rpc-nfsd]# cat /etc/nfs.conf
> [nfsd]
> rdma=y            <<<<<<<<< boolean YES
> [root@ rpc-nfsd]# systemctl restart nfs-server && cat /proc/fs/nfsd/portlist | grep -w rdma
> rdma 20049
> rdma 20049
> [root@ rpc-nfsd]# vi /etc/nfs.conf
> [root@ rpc-nfsd]# cat /etc/nfs.conf
> [nfsd]
> rdma=n            <<<<<<<<< boolean NO
> [root@ rpc-nfsd]# systemctl restart nfs-server && cat /proc/fs/nfsd/portlist | grep -w rdma
> [root@ rpc-nfsd]# vi /etc/nfs.conf
> [root@ rpc-nfsd]# cat /etc/nfs.conf
> [nfsd]
> rdma=12345        <<<<<<<<< previous pattern
> [root@ rpc-nfsd]# systemctl restart nfs-server && cat /proc/fs/nfsd/portlist | grep -w rdma
> rdma 12345
> rdma 12345
> [root@ rpc-nfsd]# vi /etc/nfs.conf
> [root@ rpc-nfsd]# cat /etc/nfs.conf
> [nfsd]
> rdma=yes          <<<<<<<<< boolean YES
> rdma-port=54321   <<<<<<<<< another port number
> [root@ rpc-nfsd]# systemctl restart nfs-server && cat /proc/fs/nfsd/portlist | grep -w rdma
> rdma 54321
> rdma 54321
> [root@ rpc-nfsd]# vi /etc/nfs.conf
> [root@ rpc-nfsd]# cat /etc/nfs.conf
> [nfsd]
> rdma=n          <<<<<<<<< boolean NO won't enable it even with rdma-port set
> rdma-port=54321
> [root@ rpc-nfsd]# systemctl restart nfs-server && cat /proc/fs/nfsd/portlist | grep -w rdma
> [root@ rpc-nfsd]# vi /etc/nfs.conf
> [root@ rpc-nfsd]# cat /etc/nfs.conf
> [nfsd]
> #rdma=n
> rdma-port=54321
> [root@ rpc-nfsd]# systemctl restart nfs-server && cat /proc/fs/nfsd/portlist | grep -w rdma
> [root@ rpc-nfsd]# 
> ~~~~~~~~~~~~~~~~~~~~~~~
> 
> Thanks,
> Yongcheng
> 
> ---
>  nfs.conf            | 1 +
>  utils/nfsd/nfsd.c   | 9 ++++++++-
>  utils/nfsd/nfsd.man | 6 +++++-
>  3 files changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/nfs.conf b/nfs.conf
> index 85097fd1..186a5b19 100644
> --- a/nfs.conf
> +++ b/nfs.conf
> @@ -63,6 +63,7 @@
>  # vers4.1=y
>  # vers4.2=y
>  # rdma=n
> +# rdma-port=20049
>  #
>  [statd]
>  # debug=0
> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
> index b256bd9f..a412a026 100644
> --- a/utils/nfsd/nfsd.c
> +++ b/utils/nfsd/nfsd.c
> @@ -92,7 +92,14 @@ main(int argc, char **argv)
>  	port = conf_get_str("nfsd", "port");
>  	if (!port)
>  		port = "nfs";
> -	rdma_port = conf_get_str("nfsd", "rdma");
> +	if (conf_get_bool("nfsd", "rdma", false)) {
> +		rdma_port = conf_get_str("nfsd", "rdma-port");
> +		if (!rdma_port)
> +			rdma_port = "nfsrdma";
> +	}
> +	/* backward compatibility - nfs.conf used to set rdma port directly */
> +	if (!rdma_port)
> +		rdma_port = conf_get_str("nfsd", "rdma");
>  	if (conf_get_bool("nfsd", "udp", NFSCTL_UDPISSET(protobits)))
>  		NFSCTL_UDPSET(protobits);
>  	else
> diff --git a/utils/nfsd/nfsd.man b/utils/nfsd/nfsd.man
> index d83ef869..2701ba78 100644
> --- a/utils/nfsd/nfsd.man
> +++ b/utils/nfsd/nfsd.man
> @@ -144,7 +144,11 @@ The lease time for NFSv4, in seconds.
>  Set the port for TCP/UDP to bind to.
>  .TP
>  .B rdma
> -Set RDMA port.  Use "rdma=nfsrdma" to enable standard port.
> +Enable RDMA port (with "on" or "yes" etc) on the standard port
> +("nfsrdma", port 20049).
> +.TP
> +.B rdma-port
> +Set an alternate RDMA port.
>  .TP
>  .B UDP
>  Enable (with "on" or "yes" etc) or disable ("off", "no") UDP support.
> 
