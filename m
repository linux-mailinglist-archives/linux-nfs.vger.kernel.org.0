Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604A44EB003
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Mar 2022 17:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbiC2PN1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Mar 2022 11:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbiC2PNZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Mar 2022 11:13:25 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1982E22C8E8
        for <linux-nfs@vger.kernel.org>; Tue, 29 Mar 2022 08:11:42 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BC605BD6; Tue, 29 Mar 2022 11:11:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BC605BD6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1648566701;
        bh=o+Rp/6vqThiRAONR1N9RGjikcnzSGysZQHo/LAlC8LA=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=rKzzS0YnouHtkocFoWWOyWRStXmFY4eWnlnbEkivQbFsiKCMBFmODr3IvuSFB/8Ka
         l+gzMBNRaJAjUrKLYn2kRdmKIZ8393ybV+VOOQbD8h3DvlcONlW6FdVDLaJAOnOLEm
         Y1vDeA46b94SRLz9biL7Bz2U2Qft30qAxAkb6654=
Date:   Tue, 29 Mar 2022 11:11:41 -0400
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Neil Brown <neilb@suse.de>,
        Benjamin Coddington <bcodding@redhat.com>,
        Steve Dickson <SteveD@RedHat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH/RFC] NFSv4: ensure different netns do not share
 cl_owner_id
Message-ID: <20220329151141.GA29634@fieldses.org>
References: <164816787898.6096.12819715693501838662@noble.neil.brown.name>
 <CC04FF50-B936-456D-8BF0-4BF04647B4BC@oracle.com>
 <164844195133.6096.11388357137493699567@noble.neil.brown.name>
 <A526C0BA-D123-4A32-BB85-E82D5494043B@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A526C0BA-D123-4A32-BB85-E82D5494043B@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Mar 28, 2022 at 02:08:31PM +0000, Chuck Lever III wrote:
> Note also that the protocol allows a CLID_INUSE response to return
> the IP address of the conflicting client, but NFSD doesn't do that,
> I guess as a security measure.

The information disclosure sounds mild and not too surprising--mountd
already hands out information about v2/v3 clients (used by "showmount").

Chances are we just didn't get around to it.  If it'd help debug this
kind of problem, I think it'd be worth it.

--b.
