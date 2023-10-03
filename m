Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81FFD7B7176
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Oct 2023 21:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjJCTDE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Oct 2023 15:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjJCTDD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Oct 2023 15:03:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22332AB
        for <linux-nfs@vger.kernel.org>; Tue,  3 Oct 2023 12:03:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59B56C433C7;
        Tue,  3 Oct 2023 19:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696359780;
        bh=suZXgFxQ4zV1QYIU40dPflLZY9Mx9HOz24DVnFy6DRc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U1jHvBUY9yOEnlptDs42Z3K9NHB0aPr83aH4+gx+5K1pXzP7/+o6Xo4P2osWReDjJ
         Fk9ghuW7MemB3U0NphT0aUa4inxB8Rzu8R6rP7r6MHApF2w9pyrfJfSnbjZZoTClKc
         mC2IaxmoFPmUNQZGPTDDhTDuxj9jWxeLgLbzJ7hXXL3Ub6+jjAQLqaSUtCakDnG009
         XQKOWv6m06boHpwTgyUHQj+4T0OJwhKbJwZDwELwYPwuB5/UQhRLERfCK0jrVQwB03
         3EFpnGmdciEwTITQMDRYM9QGXX05dDlzTdZGOdGnnr7p8gIgK2GeC5HPK+/0TK0N9B
         /3bVeGhH7jR5w==
Date:   Tue, 3 Oct 2023 12:02:59 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Jeff Layton <jlayton@kernel.org>, Neil Brown <neilb@suse.de>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH v8 1/3] Documentation: netlink: add a YAML spec for
 nfsd_server
Message-ID: <20231003120259.39c6609a@kernel.org>
In-Reply-To: <F39762FD-DFE3-4F17-9947-48A0EF67B07F@oracle.com>
References: <cover.1694436263.git.lorenzo@kernel.org>
        <47c144cfa1859ab089527e67c8540eb920427c64.1694436263.git.lorenzo@kernel.org>
        <20231003105540.75a3e652@kernel.org>
        <F39762FD-DFE3-4F17-9947-48A0EF67B07F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 3 Oct 2023 18:40:29 +0000 Chuck Lever III wrote:
> I've made similar modifications to Lorenzo's original
> contribution. The current updated version of this spec
> is here:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?h=nfsd-next&id=55f55c77f624066895470306898190f090e00cda

Great! I noticed too late :)
Just the attr listing is missing in the spec, then.
