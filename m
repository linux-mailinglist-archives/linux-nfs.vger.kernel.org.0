Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4525EDA02
	for <lists+linux-nfs@lfdr.de>; Wed, 28 Sep 2022 12:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiI1KXw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 28 Sep 2022 06:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiI1KXv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 28 Sep 2022 06:23:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7011D925B2
        for <linux-nfs@vger.kernel.org>; Wed, 28 Sep 2022 03:23:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7C7861E0C
        for <linux-nfs@vger.kernel.org>; Wed, 28 Sep 2022 10:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE551C433C1;
        Wed, 28 Sep 2022 10:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664360629;
        bh=HjMm0aQZMhrhJhG6Ds81mGVPW1OWdeG3ZQV50qoVCTA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hSy1h5DlTMH8rjjtJFTkM7o0ji0loJjg6cD6s7HABa8h3fHHkbyio1o42P3nGFO93
         MSrRWZMmPLUgziOM05UkIOWECOYEwhv7FHaon6LnoQ3l0bIiYBrPxmkFLPybbIWl/Q
         3n56eWBuYWZ1NpBgavRDPmkmQH0+5t4ooMdIl7CEfoxP3cwJ2PR7eMABRI4ru5Pa2m
         5aDGRWI/NUarjgjKXYuJm02WaQON/GVWsmmK48wF9qpB1xXK7A8xbJloyY/M1SvCeR
         AxVn6YJHLjITbwiT8H+nmD7BuajJ8dNe4MVSAvbTwuZsn82uDIGWJfcNHaJU7kIPS2
         /aEVG8lYsKlrw==
Message-ID: <0dad33838841ca01b1b47317919b4b4d2e59e5e4.camel@kernel.org>
Subject: Re: [PATCH RFC 0/2] Replace file_hashtbl with an rhashtable
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     bfields@fieldses.org
Date:   Wed, 28 Sep 2022 06:23:47 -0400
In-Reply-To: <166429914973.4564.115423416224540586.stgit@manet.1015granger.net>
References: <166429914973.4564.115423416224540586.stgit@manet.1015granger.net>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2022-09-27 at 13:22 -0400, Chuck Lever wrote:
> Hi, while testing I noticed that sometimes thousands of items are
> inserted into file_hashtbl, but it's a small fixed-size hash. That
> makes the buckets in file_hashtbl larger than two or three items.
> The comparison function (fh_match) used while walking through the
> buckets is expensive and cache-unfriendly.
>=20
> The following patches seem to help alleviate that overhead.
>=20
> ---
>=20
> Chuck Lever (2):
>       NFSD: Use const pointers as parameters to fh_ helpers.
>       NFSD: Use rhashtable for managing nfs4_file objects
>=20
>=20
>  fs/nfsd/nfs4state.c | 227 ++++++++++++++++++++++++++++++--------------
>  fs/nfsd/nfsfh.h     |  10 +-
>  fs/nfsd/state.h     |   5 +-
>  3 files changed, 162 insertions(+), 80 deletions(-)
>=20
> --
> Chuck Lever
>=20

This set all looks reasonable to me, and I like the idea of moving to
rhashtable. You can add:

Reviewed-by: Jeff Layton <jlayton@kernel.org>
