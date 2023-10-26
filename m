Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B7A7D8925
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Oct 2023 21:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjJZTrV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Oct 2023 15:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjJZTrV (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Oct 2023 15:47:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8071AA
        for <linux-nfs@vger.kernel.org>; Thu, 26 Oct 2023 12:47:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 523E91FD9A;
        Thu, 26 Oct 2023 19:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1698349636; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FInWREaSysIRuPPt1QE2RadlyK+EqKj39IvhJuZp61c=;
        b=sfmY3qKE8yfznUNVYpk55zSA65f6q1yPT+i3lcAlhmHTmW+oJLu1kDCI04XH4jmElIeV4J
        05FTAaSgp0bhHUbExPyCUkiiucCojXVTcMbrokDmvVr9aw4qkECt2Ld5XU0Z+OyIEnj30g
        koQ6bq10AH4iUeEgmiYnijit0PhUiz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1698349636;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FInWREaSysIRuPPt1QE2RadlyK+EqKj39IvhJuZp61c=;
        b=+b6XHhuNJAkvBu/02/G2BPzB59XGmLl4bthKMzYM6nw/mQppJbnx2Y0Su/R06lnLFI89Nk
        Msdm1ZjYb/48SLAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3B281358F;
        Thu, 26 Oct 2023 19:47:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aPU2OUPCOmWUdAAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 26 Oct 2023 19:47:15 +0000
From:   Petr Vorel <pvorel@suse.cz>
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>
Cc:     linux-nfs@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Steve Dickson <steved@redhat.com>
Subject: [nfs-utils 1/2] Fix build failure due to glibc <= 2.24 and check for Linux 3.17+
Date:   Thu, 26 Oct 2023 21:47:12 +0200
Message-ID: <20231026194712.615384-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231026114522.567140-1-giulio.benetti@benettiengineering.com>
References: <20231026114522.567140-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.57
X-Spamd-Result: default: False [0.57 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.33)[75.89%]
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

interesting, I yesterday sent patch [1] solving the same problem (although it
might not be that obvious from the patchset name). Let's see which one will be
taken.

Kind regards,
Petr

[1] https://lore.kernel.org/linux-nfs/20231025205720.GB460410@pevik/T/#m4c02286afae09318f6b95ff837750708d5065cd5
