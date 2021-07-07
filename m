Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 143693BF161
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Jul 2021 23:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbhGGV2g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Jul 2021 17:28:36 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:47162 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbhGGV2g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Jul 2021 17:28:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B94BE20115;
        Wed,  7 Jul 2021 21:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1625693154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGhNc/+AdW5wf3Mdqu614qQPDo9QbYgAX0JkPQmqt8g=;
        b=m+8l5n6EuZ4AeM0q0bx51D0otl04AtW93Aar0ce1yFWacpnwpc5ww+bW9E6Zibt8vSgTtw
        a1JyokEdCUh/gM+VEwAv5fa+pLwfjLZdqxNA4o06xcLXLyU1lBHRxNiirAqpdsBS/M1ukA
        nikDy3gF5yatyJZmV7alO9n7EiujSFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1625693154;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qGhNc/+AdW5wf3Mdqu614qQPDo9QbYgAX0JkPQmqt8g=;
        b=agUZA8Cua1L+QelZDNGarmsrRBArsjWfLjgz7ykpKJxcWuhEOtuiz/D/XtIXMq1z0XjeZ9
        EFrRWzrca6fcX3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2488413AE4;
        Wed,  7 Jul 2021 21:25:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AH9bMeAb5mAvFAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 07 Jul 2021 21:25:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Daire Byrne" <daire@dneg.com>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <Anna.Schumaker@netapp.com>,
        "linux-nfs" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/rfc v2] NFS: introduce NFS namespaces.
In-reply-to: <CAPt2mGM6mcqM9orzHuyTVgX2pnG5Y7nLeM85tdZ5LoDO9XozBA@mail.gmail.com>
References: <162458475606.28671.1835069742861755259@noble.neil.brown.name>,
 <162510089174.7211.449831430943803791@noble.neil.brown.name>,
 <CAPt2mGMgCHwvmy2MA4c2E316xVYPiRy4pRdcX4-1EAALfcxz+A@mail.gmail.com>,
 <162513954601.3001.5763461156445846045@noble.neil.brown.name>,
 <CAPt2mGNCV7Sh0uXA0ihpuSVcecXW=5cMUAfiS0tYr_cTQ0Du8w@mail.gmail.com>,
 <162535340922.16506.4184249866230493262@noble.neil.brown.name>,
 <CAPt2mGNOMh0uWozi=L5H6X7aKUuh_+-QxJ7OK9e6ELiKnSh1hg@mail.gmail.com>,
 <162562036711.12832.7541413783945987660@noble.neil.brown.name>,
 <CAPt2mGM6mcqM9orzHuyTVgX2pnG5Y7nLeM85tdZ5LoDO9XozBA@mail.gmail.com>
Date:   Thu, 08 Jul 2021 07:25:49 +1000
Message-id: <162569314954.31036.11087071768390664533@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 07 Jul 2021, Daire Byrne wrote:
> I stripped out all my patches so it's just this one on top of 5.13-rc7
> and I can still reproduce it.
> 
> I can only trigger it by mounting the same export (RHEL7 server) using
> two different namespaces and performing a heavy IO benchmark to either
> mount (leaving one idle). Part of the benchmark walks thousands of
> dirs with files (hence the readdirs).
> 
> If I mount the same server twice with no (same) namespaces, even with
> the patch applied, it works fine without any crash.

That's pretty solid evidence!

I just realized that the stack trace you reported mentions
"kfree_const()".
My latest patch doesn't include that, and nfs doesn't use it at all.
Might you still be using the older patch?

NeilBrown
