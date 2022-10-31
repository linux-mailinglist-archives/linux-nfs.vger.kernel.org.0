Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0027361385B
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Oct 2022 14:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiJaNse (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Oct 2022 09:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbiJaNsd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Oct 2022 09:48:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CB21007D
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 06:48:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8D7E661248
        for <linux-nfs@vger.kernel.org>; Mon, 31 Oct 2022 13:48:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71282C433D6;
        Mon, 31 Oct 2022 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667224111;
        bh=9H492ypT1n62xUJvslo6vgQJxScJ7X1BhVMGWA6AtBw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DcfHCCpDgqDsa6Bm6gaey+f7iS2tPJLP+gk8qAg0GPSL0BNMTSXZAm8O/onlGT6EH
         /9k6k/mrP8LzxJT8ompDtyIjXpD90y/Nvwe4SZcF+vZNyBI4HV5O7P+4tqZt0/Awr6
         99M73GOsiN10CzgiMRNfzrhP2OM4WIYYHZITUovpWWMHYE5PS75e4HILJXiphnQdwg
         9YvTP1F/y4xxFSm2sJUaWSVQUOM+biJEnSp0MgJ9lEuG0ekOvHJPjbBUexrlwUJuWg
         pB5/oukEXJqOoi6j/xfd82PSSwvsAbvLGqyC+U0+KNutC00RCNhpZU2xcBk4NJYDdB
         nvhgv4k7oRoOw==
Message-ID: <298bef5fa91630478e4815f9f797fb904455d873.camel@kernel.org>
Subject: Re: [PATCH] nfsd: fix licensing header in filecache.c
From:   Jeff Layton <jlayton@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Mon, 31 Oct 2022 09:48:30 -0400
In-Reply-To: <Y1/OFbwh8WtbjKH0@infradead.org>
References: <20221026143518.250122-1-jlayton@kernel.org>
         <Y1+A7XzxKbRCCH4z@infradead.org>
         <3C6909FD-6079-48AC-93E2-BD7937E31F86@oracle.com>
         <Y1/OFbwh8WtbjKH0@infradead.org>
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

On Mon, 2022-10-31 at 06:31 -0700, Christoph Hellwig wrote:
> On Mon, Oct 31, 2022 at 01:21:45PM +0000, Chuck Lever III wrote:
> > I know you are Not A Lawyer (tm), but:
> >=20
> > The e-mail address in the copyright notice is stale. Is the convention
> > to leave stale e-mail addresses in place?
> >=20
> > So I would expect copyright ownership of this code to go to Primary Dat=
a,
> > Jeff's employer at the time. But they don't exist now either; it might
> > be difficult to get permission from them to alter this notice.
>=20
> I'm not a copyright lawyer, but I've talked to a few, so:
>=20
>  - first, does Jeff own the copyright for this code, or his employer at
>    the time?
>  - if he owns it, can cna do pretty much whatever he wants
>  - if he doesn't, I would not touch it without approval from the
>    copyright holder, which gets a little complicated for a company
>    that doesn't exist in that form any more.

I went back and looked at the PD employment contract and I think I may
not own the copyright here. There was no explicit carveout for open-
source contributions (like I have at RH).

In light of that, I guess we should drop this patch and replace it with
one that just adds the SPDX header.
--=20
Jeff Layton <jlayton@kernel.org>
