Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832487DF128
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Nov 2023 12:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjKBL3q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Nov 2023 07:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjKBL3q (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Nov 2023 07:29:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010AF1B1
        for <linux-nfs@vger.kernel.org>; Thu,  2 Nov 2023 04:29:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10027C433C7;
        Thu,  2 Nov 2023 11:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698924570;
        bh=pKPFgJVz3u8Wv+bXW8fRdhJAcd6syIMLH4TbbWM0420=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Old0fziVH9VsGU1BklUg/YYz/vjD2tfTWlLtYff4eQQmrtOf7ZXUhGsyNT6t3UD/g
         WGOWXKhvik0HuryFY0kLVYKypC6wcZqJGRWWEfVBmMTc7vnlKomqxMUIGGucbUs49V
         cXWJ64jIiAOqZsu0x9M+QkBJtmtoZkALgGQeP3U/LOoWL7TX7ZrYwKT5f4pjNMo7Vd
         SI8F7fmrL73k2Bg7C8nHGGu0N2PucXSjd94xTwHKv/zEdRfEdXXHpMh4z1xy/2TBdC
         YFJ2pkVBPyiVY/amfxgmAnIfDgcmU9UF1Cxo4vftaowSJVuvtpQ3ApT7oQ++L+MvqH
         UDRp5im+e51bA==
Message-ID: <1c79ea86a5e813ac24f57f04dab48766570c3f35.camel@kernel.org>
Subject: Re: [PATCH 0/6 v2] support admin-revocation of v4 state
From:   Jeff Layton <jlayton@kernel.org>
To:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-nfs@vger.kernel.org, Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Thu, 02 Nov 2023 07:29:29 -0400
In-Reply-To: <20231101010049.27315-1-neilb@suse.de>
References: <20231101010049.27315-1-neilb@suse.de>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-11-01 at 11:57 +1100, NeilBrown wrote:
> This set fixes two issues found by kernel test robot
> 1/ nfsd4_revoke_states() needs to be defined when not CONFIG_NFSD_V4
> 2/ nfs40_last_revoke is larger than a mechine word in 32 bit configs,
>    so needs protection - use nn->client_lock which is already taken when
>    nfs40_last_revoke is accessed.
>=20
> NeilBrown
>=20

In general, the series looks like something reasonable to do (and
something admins would welcome). I have some (long standing) concerns
around the sc_type value though that I think we probably need to address
prior to or in conjunction with this set.

Cheers,
--=20
Jeff Layton <jlayton@kernel.org>
