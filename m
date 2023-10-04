Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 851EF7B7FE5
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Oct 2023 14:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242426AbjJDMyv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 4 Oct 2023 08:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233003AbjJDMys (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Oct 2023 08:54:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AC7098
        for <linux-nfs@vger.kernel.org>; Wed,  4 Oct 2023 05:54:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED4DC433C7;
        Wed,  4 Oct 2023 12:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696424085;
        bh=buFVtBBhp48udYohs/d6/KWZI+ve9T70WPt82zJFlIU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=B/rln+1+AwApGNg0hddIzZNuNvsBFnT2wrLDNMmFreWRW7gWmgdyoY5VFfkCMAXIb
         julMP31haA7R0pO0y+PQFiG+E4dYcwDedCHkD8QaSlADHRI/XnXXbnlBLjhfwsExyT
         3zvwEiHxfDQEx7g7/edR5XN+PSg8fFAT90s6x6DiPdlbU4wx2YHXQ2gIIc2MdvEclh
         msoHyJsm2ot8kyuQO9eMqAbd4X2r+fpBMowEUbbo5ZrOz8vWGn05TKTJDafsCm/Hb9
         WBiqw1/G83xT0X7Ve2juvlqW1X1gcqwry04aF9oUfB8NUHr5iCcWHulgp5psZOVf+h
         V0Q+EaMLOG+6Q==
Message-ID: <f28ffe9a71d4c01cc4a996a018259af0e8d93340.camel@kernel.org>
Subject: Re: [PATCH v1 0/4] Clean up XDR encoders for NFSv4.1 utility
 operations
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <cel@kernel.org>, linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Wed, 04 Oct 2023 08:54:43 -0400
In-Reply-To: <169625819958.1640.14102064750083176117.stgit@klimt.1015granger.net>
References: <169625819958.1640.14102064750083176117.stgit@klimt.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-10-02 at 10:51 -0400, Chuck Lever wrote:
> Tidy up the server-side XDR encoders for CREATE_SESSION and
> SEQUENCE results. Series applies to nfsd-next. See topic branch
> "nfsd4-encoder-overhaul" in this repo:
>=20
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
>=20
> ---
>=20
> Chuck Lever (4):
>       NFSD: Add a utility function for encoding sessionid4 objects
>       NFSD: Add nfsd4_encode_channel_attr4()
>       NFSD: Restructure nfsd4_encode_create_session()
>       NFSD: Clean up nfsd4_encode_sequence()
>=20
>=20
>  fs/nfsd/nfs4xdr.c | 163 +++++++++++++++++++++++++++-------------------
>  fs/nfsd/xdr4.h    |   2 +
>  2 files changed, 99 insertions(+), 66 deletions(-)
>=20
> --
> Chuck Lever
>=20

Reviewed-by: Jeff Layton <jlayton@kernel.org>
