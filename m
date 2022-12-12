Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE64649E9E
	for <lists+linux-nfs@lfdr.de>; Mon, 12 Dec 2022 13:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231314AbiLLM0c (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 12 Dec 2022 07:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231795AbiLLM0b (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 12 Dec 2022 07:26:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7831BB1DE
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 04:26:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0143A61007
        for <linux-nfs@vger.kernel.org>; Mon, 12 Dec 2022 12:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A1F2C433EF;
        Mon, 12 Dec 2022 12:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670847989;
        bh=sjbqlz5cHOTAKQN4+Lq2vnMFtii1um5UUi9d7dTRNk8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G7Ois/J1YxYwHGsvW7/6YJHNiuGAeRZ7jjsaPHqA/4bFp2HjnzeN08M1PLShGYhXS
         lBbcfeLt9i6f5dB8nFMvUYi20GwifvoAOFgi9tfcTMxBTctLqJnfccM8GAz7Ds+biI
         wZxynuUHd4T5nJxokkTKtmztjuiziWc7wPBOg+mYeHMsQkf+ZVTHp+RZwfLwzUIJ5U
         maS5PKqns5BCD+XV1jyCnL3QIi3Cn+Vn3/08ZiRK2tJZslXd6QMv7tVxys0lbZS3gz
         fVr1/xPtzFd799JZbP/3NDlcFqVUAx1lkZ6xXPfXS/TPPeUPQfC9Q4bVzyMkWx3zC1
         zSWK8Fry+mWYw==
Message-ID: <74076faddd6a92de8c293aad317860a65f8a779a.camel@kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix use-after-free in __nfs42_ssc_open()
From:   Jeff Layton <jlayton@kernel.org>
To:     Greg KH <greg@kroah.com>, Xingyuan Mo <hdthky0@gmail.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>, chuck.lever@oracle.com,
        kolga@netapp.com, linux-nfs@vger.kernel.org, security@kernel.org
Date:   Mon, 12 Dec 2022 07:26:27 -0500
In-Reply-To: <Y5cXkyWUVf433sd5@kroah.com>
References: <1670786549-27041-1-git-send-email-dai.ngo@oracle.com>
         <CALV6CNOO-Ppv7QfqHo9RKivv-1NUrezbuYN2krrNu4REuchtMA@mail.gmail.com>
         <Y5cXkyWUVf433sd5@kroah.com>
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

On Mon, 2022-12-12 at 12:59 +0100, Greg KH wrote:
> On Mon, Dec 12, 2022 at 07:22:38PM +0800, Xingyuan Mo wrote:
> > Can I share the patch with the linux-distros list, so that
> > distros can do their own testing and preparations?
>=20
> Be _VERY_ aware of the rules regarding that list before you send
> anything as you are going to have some very strict rules put on you with
> regards to what you must do once you post to them.
>=20
> Personally, I would prefer if this gets into Linus's tree first so that
> we can get it into a stable release before letting distros know about
> it, otherwise you are forcing me into a very tight schedule that might
> require you to tell the world about the problem _BEFORE_ the fix is in
> Linus's or any stable kernel trees.
>=20

I think that ship has sailed, as the linux-nfs list was cc'ed on this
patch.
--=20
Jeff Layton <jlayton@kernel.org>
