Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58AA83AE2A1
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Jun 2021 07:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbhFUFPs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Jun 2021 01:15:48 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:48284 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhFUFPq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Jun 2021 01:15:46 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 01D6E1FD2A;
        Mon, 21 Jun 2021 05:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624252412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSm3BeKTVRHfNdji1+7Zgv6lEY28TkAM1A0d1NHpK8c=;
        b=c8Vqp36J268rgBYp6RIU/lXl3QptUgj1f/qqc9YSkpQUgj3wpj2v3AflYH5zca+9RUqhOf
        9MUHF2OU3VDqF3iDL9OdoKNXLVJNdV4kJ5K1lk22FKVVF45X56Wuxf8EehAGWFmikqsMG1
        gSMa66FuZYSaGrRPgmvP4BFa2PAdbXs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624252412;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSm3BeKTVRHfNdji1+7Zgv6lEY28TkAM1A0d1NHpK8c=;
        b=byGZnzGC+9jjbpxcBmiHEPQ0ST+5i+EKcfSddTT1csBReUhT3A1N6RJ4IvC3cr9F6191wm
        EW8BkZy85RhLpaAw==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id F1763118DD;
        Mon, 21 Jun 2021 05:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1624252411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSm3BeKTVRHfNdji1+7Zgv6lEY28TkAM1A0d1NHpK8c=;
        b=Rw0AHCdMq8i/b0yYeCm4hF3T36D2dlK8ZokTEg3xXrlMkc09Qcu7ZulzVyhLR9P1Tjg5IV
        hC1XBZiZV+69eEeqmTMUyPqYNh+W+gKXa0iliIcXwHqJGFb1fZ71L0zbynNKs/QWWGq1ns
        KfWwJEWt0LHRPnb9bEcaNtYKftaZU4I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1624252411;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OSm3BeKTVRHfNdji1+7Zgv6lEY28TkAM1A0d1NHpK8c=;
        b=+h4QL8Di4bGSSouT21p1K8u0UeICxm5P5hKh+5pyMASQnSagLPQPyJhjbCAdASkwOfXfEL
        uVz9v9pg5WCFnqDg==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id hP7xJ/of0GAZUwAALh3uQQ
        (envelope-from <neilb@suse.de>); Mon, 21 Jun 2021 05:13:30 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Wang Yugui" <wangyugui@e16-tech.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: any idea about auto export multiple btrfs snapshots?
In-reply-to: <162425113589.17441.4163890972298681569@noble.neil.brown.name>
References: <20210617122852.BE6A.409509F4@e16-tech.com>,
 <162397637680.29912.2268876490205517592@noble.neil.brown.name>,
 <20210618152631.F3DE.409509F4@e16-tech.com>,
 <162425113589.17441.4163890972298681569@noble.neil.brown.name>
Date:   Mon, 21 Jun 2021 15:13:27 +1000
Message-id: <162425240757.17441.3695249639927377778@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> > It seems more fixes are needed.
> 
> I think the problem is that the submount doesn't appear in /proc/mounts.
> "nfsd_fh()" in nfs-utils needs to be able to map from the uuid for a
> filesystem to the mount point.  To do this it walks through /proc/mounts
> checking the uuid of each filesystem.  If a filesystem isn't listed
> there, it obviously fails.
> 
> I guess you could add code to nfs-utils to do whatever "btrfs subvol
> list" does to make up for the fact that btrfs doesn't register in
> /proc/mounts.

Another approach might be to just change svcxdr_encode_fattr3() and
nfsd4_encode_fattr() in the 'FSIDSOJURCE_UUID' case to check if
dentry->d_inode has a different btrfs volume id to
exp->ex_path.dentry->d_inode.
If it does, then mix the volume id into the fsid somehow.

With that, you wouldn't want the first change I suggested.

NeilBrown
