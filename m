Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2006965D27A
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 13:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjADMYD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Jan 2023 07:24:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjADMYC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 07:24:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978F8DC
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 04:24:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 323896142C
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 12:24:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E8CC433EF;
        Wed,  4 Jan 2023 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672835040;
        bh=cl8QEa+4LKO/Jvp4GMZ0+G8c9V8uH7Yl2lEg3tdTWa8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=KoBaZp5qwNqtOZPQJ8q5FEEb0dORSKMLlXdhOranJu3k2EVwekLEVNO0wU3qLzYBF
         SxsOJNHDIVLAYE2g/w28qwrodwsNuOjIRvoNqGEfpcYaPSTojCCMcuaUwQVV2k3Vib
         RJDVQl7MVDnrktkpKFTKOKccNeOhTUNbQB9pyHNWSJOSOSOGf+RZ1n3uI51fbUkP0C
         puNjTfEK3G4ZJwSTAVptVdeKYNfBB2orHBLkkTe2VCBy6oIX9R/S9SXtZjm17If6R2
         9jTrViS5UTQvKtkM0kdCmeIIOdet0kWOk3AbXQY994sBM57nlbIaDzjKVeGhdzSJ62
         PZ540DIjwnxlQ==
Message-ID: <b81f1eb708b3d0fb60bde23ebd1dfd6fdb87aa3b.camel@kernel.org>
Subject: Re: [nfs-utils PATCH] Don't allow junction tests to trigger
 automounts
From:   Jeff Layton <jlayton@kernel.org>
To:     steved@redhat.com
Cc:     linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
        JianHong Yin <jiyin@redhat.com>
Date:   Wed, 04 Jan 2023 07:23:58 -0500
In-Reply-To: <20221213160104.198237-1-jlayton@kernel.org>
References: <20221213160104.198237-1-jlayton@kernel.org>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-12-13 at 11:01 -0500, Jeff Layton wrote:
> JianHong reported some strange behavior with automounts on an nfs server
> without an explicit pseudoroot. When clients issued a readdir in the
> pseudoroot, automounted directories that were not yet mounted would show
> up even if they weren't exported, though the clients wouldn't be able to
> do anything with them.
>=20
> The issue was that triggering the automount on a directory would cause
> the mountd upcall to time out, which would cause nfsd to include the
> automounted dentry in the readdir response. Eventually, the automount
> would work and report that it wasn't exported and subsequent attempts to
> access the dentry would (properly) fail.
>=20
> We never want mountd to trigger an automount. The kernel should do that
> if it wants to use it. Change the junction checks to do an O_PATH open
> and use fstatat with AT_NO_AUTOMOUNT.
>=20
> Cc: Chuck Lever <chuck.lever@oracle.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2148353
> Reported-by: JianHong Yin <jiyin@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  support/junction/junction.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20

Ping? Steve, can you comment on (or merge) this patch?

Thanks,
--=20
Jeff Layton <jlayton@kernel.org>
