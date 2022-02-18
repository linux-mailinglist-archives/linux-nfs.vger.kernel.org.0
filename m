Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C54C4BB382
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Feb 2022 08:47:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbiBRHrO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Feb 2022 02:47:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231867AbiBRHrN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Feb 2022 02:47:13 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3912C2B4
        for <linux-nfs@vger.kernel.org>; Thu, 17 Feb 2022 23:46:55 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 7B0811F383;
        Fri, 18 Feb 2022 07:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1645170414; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHrt3M6sZNd60JUF8YLyHekFJeePGgLf3gYMiBzYWNM=;
        b=dohbUWzxKhRDpb5lCJyzVIUbUM933CHZIDlfJBDsHEKN+PXvZcHfw9zjsmvJCnDH8IkNgA
        +KBX889aSimJ1nzbFf32DBamRNRvk3anf/6QRcEd7UrRHRocEGxRsztjf78hUwcRUPgx0n
        NazJqCFB09f/4QXoSa02Jic/zt2AMUQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1645170414;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fHrt3M6sZNd60JUF8YLyHekFJeePGgLf3gYMiBzYWNM=;
        b=4W8mEjtzJImqz2SobaktZ+Ev/fupML/l+BGBdRA5Pj+hAiwoeopqm+fKdjNR5EhWGSBMBg
        uOIyz/s1rl95t6Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1C8F013BD8;
        Fri, 18 Feb 2022 07:46:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wGmPMuxOD2KcOwAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 18 Feb 2022 07:46:52 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Daire Byrne" <daire@dneg.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        "Patrick Goetz" <pgoetz@math.utexas.edu>,
        "linux-nfs" <linux-nfs@vger.kernel.org>
Subject: Re: parallel file create rates (+high latency)
In-reply-to: <CAPt2mGOx0qNTWoY9vmyVBtZ3gxdbv5qQ-2qVbtqWW9FiZFRhEg@mail.gmail.com>
References: <CAPt2mGOaRsKOiL_wuSK_D5oYYnn0R-pvVsZc5HYGdEbT2FngtQ@mail.gmail.com>,
 <20220124193759.GA4975@fieldses.org>,
 <adce2b72-ed5c-3056-313c-caea9bad4e15@math.utexas.edu>,
 <20220125212055.GB17638@fieldses.org>,
 <164315533676.5493.13243313269022942124@noble.neil.brown.name>,
 <20220126025722.GD17638@fieldses.org>,
 <CAPt2mGP2guMMf1C9VoQ0AvZ819jPuz0vDoEzJJhtL8q5DJ300A@mail.gmail.com>,
 <CAPt2mGNXq==1KUskF3U6-CDeoX57=d7NW4Qn_esDqarf9bTBaw@mail.gmail.com>,
 <20220211155949.GA4941@fieldses.org>,
 <CAPt2mGOx0qNTWoY9vmyVBtZ3gxdbv5qQ-2qVbtqWW9FiZFRhEg@mail.gmail.com>
Date:   Fri, 18 Feb 2022 18:46:49 +1100
Message-id: <164517040900.10228.8956772146017892417@noble.neil.brown.name>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 18 Feb 2022, Daire Byrne wrote:
> On Fri, 11 Feb 2022 at 15:59, J. Bruce Fields <bfields@fieldses.org> wrote:
> 
> > I think the path forward would be to update Neil's patch, add your
> > performance data, send it to Al and linux-fsdevel, and see if we can get
> > some idea what remains to be done to get this right.
> 
> If Neil or anyone else is able to do that work, I'm happy to test and
> provide the numbers.
> 
> If I could update the patch myself, I would have happily contributed
> but I lack the experience or knowledge. I'm great at identifying
> problems, but not so hot at solving them :)
> 

I've ported it to mainline without much trouble.  I started some simple
testing (parallel create/delete of the same file) and hit a bug quite
easily.  I fixed that (eventually) and then tried with more than 1 CPU,
and hit another bug.  But then it was quitting time.  If I can get rid
of all the easy to find bugs, I'll post it with a CC to you, and you can
find some more for me!

Thanks,
NeilBrown
