Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D011253FDA2
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jun 2022 13:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243056AbiFGLhr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 7 Jun 2022 07:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243040AbiFGLhj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 7 Jun 2022 07:37:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198B41EAF9
        for <linux-nfs@vger.kernel.org>; Tue,  7 Jun 2022 04:37:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0C74D21B8E;
        Tue,  7 Jun 2022 11:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1654601855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHjfrkhFqnB5JfPM/qau9zNt05sqMm4plmkPtfmkW2A=;
        b=PF3yHUVfIKw59s33PqAiKOumcrTRrJC/gx0XOSOK5Hah1F31nEpEutTThXhe6pLiI8tG93
        DVdVieHlhSZTCwLjmOlfiZ5hptoM9ZLllUowmcUPt7n7x4j7J3qS8NgeHlX5IyYKD7xOfM
        Qf9Ifo/UYHxtJzpRsSsbXTXJc5ARC9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1654601855;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gHjfrkhFqnB5JfPM/qau9zNt05sqMm4plmkPtfmkW2A=;
        b=1RPduMqb9Irou2I4i5hTbVhxOFCfWaMGtup1qVHZmfqaU0wOhub2zibgYCi4a4GCMZSWo3
        1GYD9qeyj3ky1xBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3DF0F13638;
        Tue,  7 Jun 2022 11:37:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5uszO304n2JScAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 07 Jun 2022 11:37:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v1 0/5] Fix NFSv3 READDIRPLUS failures
In-reply-to: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>
References: <165445865736.1664.4497130284832282034.stgit@bazille.1015granger.net>
Date:   Tue, 07 Jun 2022 21:37:30 +1000
Message-id: <165460185094.22243.5006042503446283679@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 06 Jun 2022, Chuck Lever wrote:
> While looking into the filecache CPU soft lock-up issue, I ran
> across this problem. I thought I could run it down in just an
> afternoon (I was wrong) and that this problem probably affects more
> users than the soft lock-up (jury's still out).
>=20
> Anyway, NFSD's new READDIRPLUS dirent encoder blows past the end of
> the directory payload xdr_stream when the client requests more than
> a page worth of directory entries. I tracked this down to how
> xdr_get_next_encode_buffer() computes xdr->end. First patch in this
> series is the fix. The remaining patches are clean-ups and
> optimizations.
>=20
> I want to get this into 5.19-rc quickly. I would appreciate getting
> at least two R-b's for this series.

Just for completeness:
  Reviewed-by: NeilBrown <neilb@suse.de>
for the whole series. Nothing I saw would justify any delay.

NeilBrown

>=20
> ---
>=20
> Chuck Lever (5):
>       SUNRPC: Fix the calculation of xdr->end in xdr_get_next_encode_buffer=
()
>       SUNRPC: Optimize xdr_reserve_space()
>       SUNRPC: Clean up xdr_commit_encode()
>       SUNRPC: Clean up xdr_get_next_encode_buffer()
>       SUNRPC: Remove pointer type casts from xdr_get_next_encode_buffer()
>=20
>=20
>  net/sunrpc/xdr.c | 31 ++++++++++++++++++++++---------
>  1 file changed, 22 insertions(+), 9 deletions(-)
>=20
> --
> Chuck Lever
>=20
>=20
