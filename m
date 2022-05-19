Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABBE052DD5A
	for <lists+linux-nfs@lfdr.de>; Thu, 19 May 2022 21:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbiESTB3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 19 May 2022 15:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244387AbiESTBP (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 19 May 2022 15:01:15 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06A263BE
        for <linux-nfs@vger.kernel.org>; Thu, 19 May 2022 12:01:10 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 497835BD0; Thu, 19 May 2022 15:01:10 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 497835BD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1652986870;
        bh=nPgey4YDRXgQFxQJ5nJwhU8AaDBu8+8Fm7D2pGsDU54=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ip3CiXGsGgtN2Sen9qKV74PNGqIARkm/E+oU0BoKj6Bx411IzimldNAFacnrz+VhL
         jy6s5TWN2FUvAUepVGCqXvgCYEt3L6/yn5FaRDdMwy+Gv1eEYyPWCdaXrKwLsLHDSr
         NxnhupiQhk7zJFMQxPVMp9nsVlSJvk3OH3oIv6M8=
Date:   Thu, 19 May 2022 15:01:10 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Steve Dickson <steved@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "trondmy@kernel.org" <trondmy@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/6] Allow nfs4-acl-tools to access 'dacl' and 'sacl'
Message-ID: <20220519190110.GD23564@fieldses.org>
References: <20220514144436.4298-1-trondmy@kernel.org>
 <20220515015946.GB30004@fieldses.org>
 <15c4602658aff025b6d84e2b9461378930cbd802.camel@hammerspace.com>
 <627133c7-dab9-db0b-5fdf-ecb95820e76a@redhat.com>
 <20220519135311.GC23564@fieldses.org>
 <765e7b64-c5dd-a62e-3762-8e4ecec9f0d8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <765e7b64-c5dd-a62e-3762-8e4ecec9f0d8@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 19, 2022 at 02:52:25PM -0400, Steve Dickson wrote:
> Also the links on the main page of linux-nfs.org [2]
> will need to point to [1]. I guess I don't have an
> account on that box, so I can not make that change.

https://wiki.linux-nfs.org/wiki/index.php/Special:RequestAccount

--b.
