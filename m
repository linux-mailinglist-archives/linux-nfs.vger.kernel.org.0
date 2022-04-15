Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8D6502C78
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Apr 2022 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354951AbiDOPWl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Apr 2022 11:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343593AbiDOPWa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Apr 2022 11:22:30 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731372A738
        for <linux-nfs@vger.kernel.org>; Fri, 15 Apr 2022 08:19:59 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 2E7435F2E; Fri, 15 Apr 2022 11:19:59 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 2E7435F2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1650035999;
        bh=3dTZu4JNW/LUxpXADTtRsruwcYScAVynxd3demDRQwY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NGd7srA0vKc3jeBvGUINmhGYtIUQhNVykUycviFYY49ZDMdnMIGYm9zC9ReF9Lxye
         2py6sYMkOh8UJM7QZxMc4TL937V+O0jAW9JguD/93sO1A1HGzysMwPvkWF/Zuzc07B
         PGy7vkQssLz4MD9v4WK7XRFvHBCR0BiMd3zlLHz4=
Date:   Fri, 15 Apr 2022 11:19:59 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC v19 06/11] NFSD: Update find_clp_in_name_tree() to
 handle courtesy client
Message-ID: <20220415151959.GA24358@fieldses.org>
References: <1648742529-28551-1-git-send-email-dai.ngo@oracle.com>
 <1648742529-28551-7-git-send-email-dai.ngo@oracle.com>
 <20220401152109.GB18534@fieldses.org>
 <52CA1DBC-A0E2-4C1C-96DF-3E6114CDDFFD@oracle.com>
 <8dc762fc-dac8-b323-d0bc-4dbeada8c279@oracle.com>
 <20220413125550.GA29176@fieldses.org>
 <fae06919-13de-9ebb-8259-108f6e18c801@oracle.com>
 <eaf758e8-077d-f7fe-1e02-cfaa49830d97@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eaf758e8-077d-f7fe-1e02-cfaa49830d97@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 15, 2022 at 07:56:06AM -0700, dai.ngo@oracle.com wrote:
> On 4/15/22 7:47 AM, dai.ngo@oracle.com wrote:
> >From user space, how do we force the client to use the delegation
> >state to read the file *after* doing a close(2)?
> 
> I guess we can write new pynfs test to do this, but I'd like to avoid
> it if possible.

Right, this would require pynfs tests.  If you don't think they'd be
that bad.  But if you don't want to do tests for each step I think
that's not the end of the world, up to you.

--b.
