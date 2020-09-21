Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBD13272AAB
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Sep 2020 17:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgIUPsn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Sep 2020 11:48:43 -0400
Received: from cerberus.halldom.com ([79.135.97.241]:38361 "EHLO
        cerberus.halldom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgIUPsn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Sep 2020 11:48:43 -0400
X-Greylist: delayed 4126 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 11:48:43 EDT
Received: from ceres.halldom.com ([79.135.97.244]:56248)
        by cerberus.halldom.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <linux-nfs@gmch.uk>)
        id 1kKMyw-0001cU-C4
        for linux-nfs@vger.kernel.org; Mon, 21 Sep 2020 15:39:54 +0100
Subject: Re: mount.nfs4 and logging
To:     linux-nfs@vger.kernel.org
References: <S1725851AbgIKKt5/20200911104957Z+185@vger.kernel.org>
 <a38a1249-c570-9069-a498-5e17d85a418a@gmch.uk>
 <f06f86ef-08bd-3974-3d92-1fbda700cc11@RedHat.com>
 <f7b9c8b4-29a6-2f28-b1d9-739c546fd557@gmch.uk>
 <20200919163353.GA15785@fieldses.org> <20200919164020.GB15785@fieldses.org>
 <12298172-f830-4f22-8612-dfbbc74b8a40@gmch.uk>
 <20200920193245.GC28449@fieldses.org>
From:   Chris Hall <linux-nfs@gmch.uk>
Message-ID: <eb64e66e-0328-f9e6-7511-1b73f67c49c1@gmch.uk>
Date:   Mon, 21 Sep 2020 15:40:01 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200920193245.GC28449@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 20/09/2020 20:32, J. Bruce Fields wrote:
> On Sun, Sep 20, 2020 at 10:56:28AM +0100, Chris Hall wrote:
...
>> Where nfsdcld, rpc.idmapd and rpc.mountd have indeed been started
>> but are not bound to any ports.

> That looks good.  (And rpc.mountd does still serve a purpose in the
> NFSv4 case, answering requests from the kernel for information related
> to exported filesystems.)

>> But rpc.statd and rpcbind have also been started, and various ports
>> have been opened, including port 111 which is bound to systemd.  Is
>> there a way to inhibit that for nfs4 only ?

> Unlike rpc.mountd, there's no reason for those to be running at all.
> You can mask thoe corresponding systemd units.

I tried masking all of: rpcbind.socket, rpcbind.service, statd.service 
and statd-notify.service.  systemctl start nfs-server.service 
(eventually) gives, according to the logging:

  nfs-mountd.service: start operation timed out. Terminating.
  nfs-mountd.service: State 'stop-sigterm' timed out. Killing.
  nfs-mountd.service: Killing process x (rpc.mountd) with signal SIGKILL.
  nfs-mountd.service: Control process exited, code=killed, status=9/KILL

If I unmask rpcbind.service, I can start nfs-server.  It no longer 
starts rpc.statd.  But I still have rpcbind running and port 111 open.

> It'd be nice if there was a way to make that happen automatically if v2
> and v3 are configured out in the configuration files, but I don't know
> how to make that happen.

It would and me neither.

Thanks,

Chris
