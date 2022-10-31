Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822A4613808
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 14:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJaN2f (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 09:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiJaN2e (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 09:28:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E745AE72
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 06:28:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B25BBB8112E
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 13:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32D9C433C1;
        Mon, 31 Oct 2022 13:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667222907;
        bh=mK+L+uUF8ZjJcFgl9wjwsAEgN3PG+XwEHbTHdwikw+k=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lmKkZjAjiNHrhY38tIjo8C+jATE63AZb8VpDhUD0dBMNYdGk/KK8EFm81F3s3BnMA
         GfSt2pKdMrAZErCYALF8iVpb13Pf/3ZCfchdJuJ4boov2w8TQGyhBdQLTxwv4pw5Ng
         eN1OZDl8pqFQvSgH+HJPvqiloGAynzafC408Ka0DINd0c715knEaqLkybhnG1wCuAu
         xlSkdaeMSuj4jdnswdDcDlKIJZx51SZ7HadK6Hekc6M741kyCRzcLLSB0GSNLIh2yw
         X/sUHUKSrlrRx1iV+sdvJOidQ6D1b4PxZBVw56fxrK7NBBYli1ZqBhTaa7wrIBX8ox
         llt8F7AohboEw==
Message-ID: <014cde00a44c7240414049ac5d179320e96df6c8.camel@kernel.org>
Subject: Re: [PATCH v3 3/4] nfsd: close race between unhashing and LRU
 addition
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 31 Oct 2022 09:28:25 -0400
In-Reply-To: <202AD086-4F1F-41D6-ABDC-BA6C91DA5BBF@oracle.com>
References: <20221028185712.79863-1-jlayton@kernel.org>
         <20221028185712.79863-4-jlayton@kernel.org>
         <08778EE0-CBDC-467B-ACA6-9D8E6719E1BB@oracle.com>
         <166716630911.13915.14442550645061536898@noble.neil.brown.name>
         <1737B8C1-5B93-4887-A673-F9AFA6ED32C0@oracle.com>
         <fb57d2cb6769dbc123e15e76ec2c23b1fa9f32be.camel@kernel.org>
         <202AD086-4F1F-41D6-ABDC-BA6C91DA5BBF@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2022-10-31 at 13:14 +0000, Chuck Lever III wrote:
>=20
> > On Oct 31, 2022, at 6:08 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Mon, 2022-10-31 at 02:51 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Oct 30, 2022, at 5:45 PM, NeilBrown <neilb@suse.de> wrote:
> > > >=20
> > > > On Sat, 29 Oct 2022, Chuck Lever III wrote:
> > > > >=20
> > > > > > On Oct 28, 2022, at 2:57 PM, Jeff Layton <jlayton@kernel.org> w=
rote:
> > > > > >=20
> > > > > > The list_lru_add and list_lru_del functions use list_empty chec=
ks to see
> > > > > > whether the object is already on the LRU. That's fine in most c=
ases, but
> > > > > > we occasionally repurpose nf_lru after unhashing. It's possible=
 for an
> > > > > > LRU removal to remove it from a different list altogether if we=
 lose a
> > > > > > race.
> > >=20
> > > Can that issue be resolved by simply adding a "struct list_head nf_di=
spose"
> > > field? That might be more straightforward than adding conditional log=
ic.
> > >=20
> >=20
> > Yes, though that would take more memory.
>=20
> Not really. pahole says struct nfsd_file is currently 40 bytes short
> of two cache lines. So adding a list_head field should not push the
> size of nfsd_file to the point where kmalloc would have to allocate
> more memory per object.
>=20
> I'm wondering if a separate list_head field would help simplify
> nfsd_file_put() ?
>=20

Probably not. It wouldn't need the flag anymore, but the logic would
still be roughly the same. We still have to check for the race between
unhashing and adding to the LRU either way.
=20
--=20
Jeff Layton <jlayton@kernel.org>
