Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 135A5271795
	for <lists+linux-nfs@lfdr.de>; Sun, 20 Sep 2020 21:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgITTcs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 20 Sep 2020 15:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726126AbgITTcr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 20 Sep 2020 15:32:47 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6319C061755
        for <linux-nfs@vger.kernel.org>; Sun, 20 Sep 2020 12:32:47 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id CEBF71C15; Sun, 20 Sep 2020 15:32:45 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org CEBF71C15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1600630365;
        bh=xVzUnc6SfnhfZS+0QOQMLGDYvpjRIEhgZoSBY3y8Puc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1bYD+rJfU5QCdOLZNB1aseVUr6OBD4P2WO6eVl6QgkqnrAISksutcz+863KXngeu
         nhT0nwKuC5VFfKp/DdKWF/iGmJTarev0ZLt2oPRGYFnB4Sj2SHGeeEP4cSYhPTiUcT
         xjuT9hquIyl7c3FahI1uu30zyMtYGKhTa0wnyMw8=
Date:   Sun, 20 Sep 2020 15:32:45 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Chris Hall <chris.hall@gmch.uk>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: mount.nfs4 and logging
Message-ID: <20200920193245.GC28449@fieldses.org>
References: <S1725851AbgIKKt5/20200911104957Z+185@vger.kernel.org>
 <a38a1249-c570-9069-a498-5e17d85a418a@gmch.uk>
 <f06f86ef-08bd-3974-3d92-1fbda700cc11@RedHat.com>
 <f7b9c8b4-29a6-2f28-b1d9-739c546fd557@gmch.uk>
 <20200919163353.GA15785@fieldses.org>
 <20200919164020.GB15785@fieldses.org>
 <12298172-f830-4f22-8612-dfbbc74b8a40@gmch.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12298172-f830-4f22-8612-dfbbc74b8a40@gmch.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sun, Sep 20, 2020 at 10:56:28AM +0100, Chris Hall wrote:
> On 19/09/2020 17:40, J. Bruce Fields wrote:
> >On Sat, Sep 19, 2020 at 12:33:53PM -0400, J. Bruce Fields wrote:
> >>For the server, you don't need rpcbind or rpc.statd for v4, but you do
> >>need rpc.idmapd, rpc.mountd and nfsdcld.
> >>
> >>rpc.mountd is the only one of those three that needs to listen on a
> >>network port, but that's only in the NFSv2/v3 case.  I'm not sure if
> >>we're getting that right.
> 
> >Looking at the code, it looks correct--I see mountd starting those
> >listeners only when v2 or v3 are configured.
> 
> Well, on the machine in question, after a reboot I have:
> 
> [root@cerberus ~]# netstat ...
> Proto Local Address           Foreign Address    State  PID/Prog
> tcp   10.25.54.61:1022        0.0.0.0:*          LISTEN 767/sshd
> tcp   10.25.54.61:1022        79.xx.xx.xx:57456  ESTAB. 770/sshd root
> [root@cerberus ~]# pstree
> systemd─┬─agetty
>         ├─atd
>         ├─auditd───{auditd}
>         ├─crond
>         ├─dbus-broker-lau───dbus-broker
>         ├─gssproxy───5*[{gssproxy}]
>         ├─mcelog
>         ├─rngd───4*[{rngd}]
>         ├─rsyslogd───2*[{rsyslogd}]
>         ├─sshd───sshd───sshd───bash───pstree
>         ├─systemd-homed
>         ├─systemd-journal
>         ├─systemd-logind
>         └─systemd-udevd
> 
> where the only port which is open is the "obscure" sshd.
> 
> Then I start nfs-server and:
> 
> [root@cerberus ~]# systemctl start nfs-server
> [root@cerberus ~]# netstat ...
> Proto Local Address           Foreign Address    State  PID/Prog
> tcp   10.25.54.61:1022        0.0.0.0:*          LISTEN 767/sshd
> tcp   79.xx.xx.xx:1001        0.0.0.0:*          LISTEN -
> tcp   0.0.0.0:46921           0.0.0.0:*          LISTEN 817/rpc.statd
> tcp   0.0.0.0:111             0.0.0.0:*          LISTEN 1/systemd
> tcp   10.25.54.61:1022        79.xx.xx.xx:57456  ESTAB. 770/sshd:
> tcp6  :::35545                :::*               LISTEN 817/rpc.statd
> tcp6  :::111                  :::*               LISTEN 1/systemd
> udp   0.0.0.0:54902           0.0.0.0:*                 817/rpc.statd
> udp   0.0.0.0:111             0.0.0.0:*                 1/systemd
> udp   0.0.0.0:62840           0.0.0.0:*                 815/rpcbind
> udp6  :::61316                :::*                      815/rpcbind
> udp6  :::111                  :::*                      1/systemd
> udp6  :::58536                :::*                      817/rpc.statd
> [root@cerberus ~]# pstree
> systemd─┬─agetty
>         ├─atd
>         ├─auditd───{auditd}
>         ├─crond
>         ├─dbus-broker-lau───dbus-broker
>         ├─gssproxy───5*[{gssproxy}]
>         ├─mcelog
>         ├─nfsdcld
>         ├─rngd───4*[{rngd}]
>         ├─rpc.idmapd
>         ├─rpc.mountd
>         ├─rpc.statd
>         ├─rpcbind
>         ├─rsyslogd───2*[{rsyslogd}]
>         ├─sshd───sshd───sshd───bash───pstree
>         ├─systemd-homed
>         ├─systemd-journal
>         ├─systemd-logind
>         └─systemd-udevd
> 
> Where nfsdcld, rpc.idmapd and rpc.mountd have indeed been started
> but are not bound to any ports.

That looks good.  (And rpc.mountd does still serve a purpose in the
NFSv4 case, answering requests from the kernel for information related
to exported filesystems.)

> But rpc.statd and rpcbind have also been started, and various ports
> have been opened, including port 111 which is bound to systemd.  Is
> there a way to inhibit that for nfs4 only ?

Unlike rpc.mountd, there's no reason for those to be running at all.
You can mask thoe corresponding systemd units.

It'd be nice if there was a way to make that happen automatically if v2
and v3 are configured out in the configuration files, but I don't know
how to make that happen.

--b.
> 
> The /etc/nfs.conf says:
> 
> [nfsd]
> debug=0
> threads=8
> host=cerberus
> port=1001
> udp=n
> tcp=y
> vers2=n
> vers3=n
> vers4=y
> vers4.0=y
> vers4.1=y
> vers4.2=y
> 
> And nothing else.  And yes, the port is intended to be "obscure".
