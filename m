Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB927DD741
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Oct 2023 21:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjJaUq5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 Oct 2023 16:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231546AbjJaUq4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 Oct 2023 16:46:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D0F9
        for <linux-nfs@vger.kernel.org>; Tue, 31 Oct 2023 13:46:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D3B332183A;
        Tue, 31 Oct 2023 20:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698785211; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSBbH5r7NIf19qebDgU+2gNb/lXtnmSkmQvbKzmWh7I=;
        b=tweumJNB4zTjafnKt4kVoVon0dy3deyDpFWeQ1jUOkC4wERo8kOq/e5W9/Vty/YfSMu4PO
        Rk6u455XZALJ5dJEgZRcKOlGjoF+0MgC6Z6+hW2+ndugAY9KzAKvfONjI9UewdczdTmoYS
        /FmstWxqiJILfbxjgQKM8A1CZla0B7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698785211;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pSBbH5r7NIf19qebDgU+2gNb/lXtnmSkmQvbKzmWh7I=;
        b=maBo1J451+HZPRRJr/krVU4sDlBWkZd9MciA3r4We5p1ebIWjPTuOghtlmm+7bBOsYEeTI
        zLQcXsDC7qO5TcCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAD48138EF;
        Tue, 31 Oct 2023 20:46:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +OduILlnQWWTTwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 31 Oct 2023 20:46:49 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Olga Kornievskaia" <kolga@netapp.com>,
        "Dai Ngo" <dai.ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>
Subject: Re: [PATCH 0/5] sunrpc: not refcounting svc_serv
In-reply-to: <C869423C-B578-4D5D-B171-444EDF2D0D02@oracle.com>
References: <20231030011247.9794-1-neilb@suse.de>,
 <9BA28F70-A3FC-4EC4-A638-A27C1867F221@oracle.com>,
 <169878484259.24305.17786556797570881562@noble.neil.brown.name>,
 <C869423C-B578-4D5D-B171-444EDF2D0D02@oracle.com>
Date:   Wed, 01 Nov 2023 07:46:46 +1100
Message-id: <169878520677.24305.4940476987470825179@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 01 Nov 2023, Chuck Lever III wrote:
> 
> > On Oct 31, 2023, at 1:40 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Wed, 01 Nov 2023, Chuck Lever III wrote:
> >> 
> >>> On Oct 29, 2023, at 6:08 PM, NeilBrown <neilb@suse.de> wrote:
> >>> 
> >>> This patch set continues earlier work of improving how threads and
> >>> services are managed.  Specifically it drop the refcount.
> >>> 
> >>> The refcount is always changed under the mutex, and almost always is
> >>> exactly equal to the number of threads.  Those few cases where it is
> >>> more than the number of threads can usefully be handled other ways as
> >>> see in the patches.
> >>> 
> >>> The first patches fixes a potential use-after-free when adding a socket
> >>> fails.  This might be the UAF that Jeff mentioned recently.
> >>> 
> >>> The second patch which removes the use of a refcount in pool_stats
> >>> handling is more complex than I would have liked, but I think it is
> >>> worth if for the result seen in 4/5 of substantial simplification.
> >> 
> >> So I need a v2 of this series, then...
> >> 
> >> - Move 4/5 to the beginning of the series (patch 1 or 2, doesn't matter)
> > 
> > I don't understand....  2 and 3 are necessary prerequisites for 4.  The
> > remove places where the refcount is used.
> 
> Hrm. that's what I was afraid of.
> 
> Isn't there a fix in 4/5 that we want applied to stable kernels,
> or did I misunderstand the email exchange between you and Jeff?
> 
That is 
 Commit bf32075256e9 ("NFSD: simplify error paths in nfsd_svc()")
which is already in nfsd-next.

NeilBrown


> 
> --
> Chuck Lever
> 
> 
> 

