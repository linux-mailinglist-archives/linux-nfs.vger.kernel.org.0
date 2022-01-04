Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8533E48464B
	for <lists+linux-nfs@lfdr.de>; Tue,  4 Jan 2022 17:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235574AbiADQ4h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 4 Jan 2022 11:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiADQ4g (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 4 Jan 2022 11:56:36 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725A2C061761
        for <linux-nfs@vger.kernel.org>; Tue,  4 Jan 2022 08:56:36 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 980D67099; Tue,  4 Jan 2022 11:56:34 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 980D67099
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641315394;
        bh=LvpWAZG2eRJg2xHYQ4CzYNWAKCXqWZMRgrbHFxJDFgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qxOTbmdTDtl270s93/RAoj8evlMkMjKyEh0+wYgHhomJt1GINxEKT8QXTB/pqVfrR
         uZgl1n8JnfUQev5AamipQErWeOyC177gfTNmDX3XNOtcnCTdxvVcvyWiQYt7KLsekD
         Lp17s0hNmcKEr/x8ukm84GtT/GkS0pl9k+AlJpK4=
Date:   Tue, 4 Jan 2022 11:56:34 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: NFSv4 OPEN returns a zero cinfo.after on tmpfs
Message-ID: <20220104165634.GE7815@fieldses.org>
References: <49640909-A7F0-4004-AF55-859621B26D38@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49640909-A7F0-4004-AF55-859621B26D38@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 24, 2021 at 04:46:26AM +0000, Chuck Lever III wrote:
> During some testing I noticed that OPEN frequently returns a
> zero in the cinfo.after field on my test share, which is tmpfs.
> Does not seem to be an issue for xfs.

Thanks for catching this.

> An easy way to address this would be to revert 428a23d2bf0c. But I
> wonder if there are any particular regression tests in the pynfs
> suite that could detect this kind of misbehavior, in case someone
> would like to try to re-implement the optimization in 428a23d2bf0c.

From a quick grep the only tests I see checking cinfo are in
nfs4.0/servertests/st_rename.py

--b.
