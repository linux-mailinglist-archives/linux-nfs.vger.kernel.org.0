Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D35D743243
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Jun 2023 03:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjF3Bei (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 21:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjF3Beh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 21:34:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13495297C
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 18:34:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 928596167C
        for <linux-nfs@vger.kernel.org>; Fri, 30 Jun 2023 01:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C525DC433C8;
        Fri, 30 Jun 2023 01:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688088876;
        bh=gtfuKL4TUbbreWWbDDa3lEkKawRkzxGB7nJ/ihRfX/c=;
        h=Subject:From:To:Cc:Date:From;
        b=O8yO0mGzvKMIqjR0Q9BRwWk/EiXtUSwFFIL298f6xYBbfZt6ycC3AhlirBBrPsM82
         C4UbkUggcfc9rj/NPPJdT8NDkeJohKhql0e2IN8tjkMRPxhmuDMsY8kYfhI7ScD+ER
         SHJdEn7kdzgtn1/hR0bmP1FFWmjQ7DkG+tT6hQQHFCYV3w2jT/G/5DZnuHmkuhQ8q4
         zZfNwEZSCmSbbyIfVhqMNJWFpLTRP9plxOfMv19NjRcafmTtB6Y/BF3A53D9AZCLhT
         LNOWZA1rjX3nkMYaYDqq0cSRFekC3KC05sCbg35HxAqpgeby2GLD8YXL70j51EL9fL
         xY+mYiaPwFG8Q==
Subject: [PATCH RFC 0/4] Encode NFSv4 attributes via a branch table
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>
Date:   Thu, 29 Jun 2023 21:34:34 -0400
Message-ID: <168808788945.7728.6965361432016501208.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Here's something just for fun. I've converted nfsd4_encode_fattr4()
to use a bitmask loop, calling an encode helper for each attribute
to be encoded. Rotten tomatoes and gold stars are both acceptible.

I was hoping for a bit of a performance gain because encode_fattr4
is called so very often, but there was not much difference at all.

The main benefit here is the hard scope boundary for each of the
separate attribute encoders -- that makes for safer code that is
easier to reason about, and might even be more straightforward to
convert to machine-generated code, if we ever want to do that.

And notably it will automatically encode the attributes in bitmask
order.

There are a few readability improvements that could be done, like
defining meaningfully-named macros for the bit positions. The ones
we have now are not directly usable for table indices. It might get
us another step closer to the XDR specification if we could find a
way to encode the whole bitmask in a single loop.

---

Chuck Lever (4):
      NFSD: Add struct nfsd4_fattr_args
      NFSD: Encode attributes in WORD0 using a bitmask loop
      NFSD: Encode attributes in WORD1 using a bitmask loop
      NFSD: Encode attributes in WORD2 using a bitmask loop


 fs/nfsd/nfs4xdr.c | 1089 +++++++++++++++++++++++++++------------------
 1 file changed, 657 insertions(+), 432 deletions(-)

--
Chuck Lever

