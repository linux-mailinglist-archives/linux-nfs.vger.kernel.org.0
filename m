Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35D333AA968
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Jun 2021 05:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhFQDNw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 16 Jun 2021 23:13:52 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:58472 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbhFQDNw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Jun 2021 23:13:52 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 3D5411FD92;
        Thu, 17 Jun 2021 03:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623899504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEx2HJjlLi8wnVmoVnhpADNTIGlVqTWhYVSGEhcKe1M=;
        b=bowKo3WdCRqOv/FFjWp9chr2kaARqbRsp4/rPK68zNDiHisLUvUVBHbVouzCGkZCev0o0k
        DyShrVEOtx/Mq5nB3gdkinCKI2UXiEFn+iGFgBjgcfA2mRyYCNmijiTLlYUbV/J5kGfJXL
        zMC/OhY5TlGS2PgrRI92j4NN65pDatE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623899504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEx2HJjlLi8wnVmoVnhpADNTIGlVqTWhYVSGEhcKe1M=;
        b=Z5oqwOFdwdoG1VMitMcxRILY10BHNCKEYkBd766QrXoLQxMY7KsN2rz9RdQkX9NyqKHk9b
        DemHYuHikgDyWBBA==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 36B20118DD;
        Thu, 17 Jun 2021 03:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623899504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEx2HJjlLi8wnVmoVnhpADNTIGlVqTWhYVSGEhcKe1M=;
        b=bowKo3WdCRqOv/FFjWp9chr2kaARqbRsp4/rPK68zNDiHisLUvUVBHbVouzCGkZCev0o0k
        DyShrVEOtx/Mq5nB3gdkinCKI2UXiEFn+iGFgBjgcfA2mRyYCNmijiTLlYUbV/J5kGfJXL
        zMC/OhY5TlGS2PgrRI92j4NN65pDatE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623899504;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sEx2HJjlLi8wnVmoVnhpADNTIGlVqTWhYVSGEhcKe1M=;
        b=Z5oqwOFdwdoG1VMitMcxRILY10BHNCKEYkBd766QrXoLQxMY7KsN2rz9RdQkX9NyqKHk9b
        DemHYuHikgDyWBBA==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id 6C/uNW69ymDKIAAALh3uQQ
        (envelope-from <neilb@suse.de>); Thu, 17 Jun 2021 03:11:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Patrick Goetz" <pgoetz@math.utexas.edu>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Use of /etc/netgroup appears to be broken in the NFS server
 version which ships with Ubuntu 20.04
In-reply-to: <2539b705-b72a-d9de-965e-7836dfd2e362@math.utexas.edu>
References: <2539b705-b72a-d9de-965e-7836dfd2e362@math.utexas.edu>
Date:   Thu, 17 Jun 2021 13:11:39 +1000
Message-id: <162389949987.29912.5411348355154532470@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 16 Jun 2021, Patrick Goetz wrote:
> Sadly, it took me a couple of days to track this down. The /etc/netgroup 
> file I'm using works perfectly on another NFS server (Ubuntu 18.04) in 
> production, so this wasn't an immediate suspicion.  However, if I use 
> this /etc/exports:
> 
>    /srv/nfs @cryo_em(rw,sync,fsid=0,crossmnt,no_subtree_check)
>    /srv/nfs/cryosparc @cryo_em(rw,sync,fsid=2,crossmnt,no_subtree_check)
> 
> Client mounts fail:
> 
> 
> root@javelina:~# mount -vvvt nfs4 cerebro:/cryosparc /cryosparc
> mount.nfs4: timeout set for Tue Jun 15 11:53:22 2021
> mount.nfs4: trying text-based options 
> 'vers=4.2,addr=128.xx.xx.xxx,clientaddr=129.xxx.xxx.xx'
> mount.nfs4: mount(2): Permission denied
> mount.nfs4: access denied by server while mounting cerebro:/cryosparc
> 
> and if I switch to specifying the host explicitly:
> 
>    /srv/nfs javelina.my.domain(rw,sync,fsid=0,crossmnt,no_subtree_check)
> 
>    /srv/nfs/cryosparc 
> javelina.mydomain(rw,sync,fsid=2,crossmnt,no_subtree_check)
> 
> the mount just works.  The tcpdump error message isn't terribly helpful 
> here:
> 
> 11:14:02.856094 IP cerebro.my.domain.nfs > javelina.my.domain.741: Flags 
> [.], ack 281, win 507, options [nop,nop,TS val 791638255 ecr 
> 2576087678], length 0
> 11:14:02.856178 IP cerebro.my.domain.nfs > javelina.my.domain.741: Flags 
> [P.], seq 1:25, ack 281, win 507, options [nop,nop,TS val 791638255 ecr 
> 2576087678], length 24: NFS reply xid 2752089303 reply ERR 20: Auth 
> Bogus Credentials (seal broken)
> 
> but after figuring out the cause of the problem, I did find a 
> corroborating RHEL error report (which you'll need a RHEL account to 
> access):
> 
>    https://access.redhat.com/solutions/3563601
> 
> I couldn't figure out how to determine the exact version of the NFS 
> server that ships with Ubuntu 20.04.  Maybe someone could explain how to 
> do this.  Running
>     /usr/sbin/rpc.nfsd --version
> doesn't do it.
> 
> 

The problem is unlikely to be the implementation of netgroups - that
hasn't changed in a long time.  It is more likely to be some subtle
configuration difference.

Can you provide the verbatim /etc/netgroups file, and the extact host
name that a DNS lookup of the client IP adress results in?

NeilBrown
