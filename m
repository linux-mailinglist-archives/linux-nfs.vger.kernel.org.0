Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6A66E900C
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Apr 2023 12:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjDTKX5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Apr 2023 06:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233960AbjDTKXZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Apr 2023 06:23:25 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E39D7689;
        Thu, 20 Apr 2023 03:22:36 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ppRQo-000Ydi-9Y; Thu, 20 Apr 2023 18:22:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 20 Apr 2023 18:22:27 +0800
Date:   Thu, 20 Apr 2023 18:22:27 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Scott Mayhew <smayhew@redhat.com>, linux-nfs@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: Add some test vectors for cmac(camellia)
Message-ID: <ZEESY6Gqs1goh8cz@gondor.apana.org.au>
References: <1119460.1681400418@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119460.1681400418@warthog.procyon.org.uk>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 13, 2023 at 04:40:18PM +0100, David Howells wrote:
>     
> Add some test vectors for 128-bit cmac(camellia) as found in
> draft-kato-ipsec-camellia-cmac96and128-01 section 6.2.
> 
> The document also shows vectors for camellia-cmac-96, and for VK with a
> length greater than 16, but I'm not sure how to express those in testmgr.
> 
> This also leaves cts(cbc(camellia)) untested, but I can't seem to find any
> tests for that that I could put into testmgr.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Herbert Xu <herbert@gondor.apana.org.au>
> cc: Chuck Lever <chuck.lever@oracle.com>
> cc: Scott Mayhew <smayhew@redhat.com>
> cc: linux-nfs@vger.kernel.org
> cc: linux-crypto@vger.kernel.org
> Link: https://datatracker.ietf.org/doc/pdf/draft-kato-ipsec-camellia-cmac96and128-01
> ---
>  crypto/testmgr.c |    6 ++++++
>  crypto/testmgr.h |   47 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 53 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
