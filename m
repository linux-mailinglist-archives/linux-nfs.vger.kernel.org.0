Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619096E2090
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Apr 2023 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjDNKTJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Apr 2023 06:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjDNKTH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Apr 2023 06:19:07 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237C34C06;
        Fri, 14 Apr 2023 03:19:03 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pnGW2-00FpcG-7Q; Fri, 14 Apr 2023 18:18:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 14 Apr 2023 18:18:50 +0800
Date:   Fri, 14 Apr 2023 18:18:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Scott Mayhew <smayhew@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: Did the in-kernel Camellia or CMAC crypto implementation break?
Message-ID: <ZDkoiqPXwIRYmeF3@gondor.apana.org.au>
References: <ZDkUSESImVSUX0RW@gondor.apana.org.au>
 <ZDi1qjVpcpr2BZfN@gondor.apana.org.au>
 <48886D84-1A04-4B07-A666-BB56684E759F@oracle.com>
 <380323.1681314997@warthog.procyon.org.uk>
 <1078650.1681394138@warthog.procyon.org.uk>
 <1235770.1681462057@warthog.procyon.org.uk>
 <1239035.1681467430@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1239035.1681467430@warthog.procyon.org.uk>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 14, 2023 at 11:17:10AM +0100, David Howells wrote:
>
> There would be just two users at the moment: sunrpc/nfs and rxrpc/afs.  I
> don't know if cifs or ceph could make use of it.

Interesting.  Could you outline how this new interface would work?
And have you looked whether the aead interface could fit into your
model?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
