Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB18553B074
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Jun 2022 02:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232326AbiFAXFv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 1 Jun 2022 19:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiFAXFv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 1 Jun 2022 19:05:51 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C74929979B
        for <linux-nfs@vger.kernel.org>; Wed,  1 Jun 2022 16:05:49 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id D0A3D26A1; Wed,  1 Jun 2022 19:05:48 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org D0A3D26A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1654124748;
        bh=FTNH/dsInWr8ygYNbfSpLcJ4QS6cXg3VlAUwqJWbcRw=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=qPY99xApi3PD+onSoHeKSl/1tNv8kcfkfz3EWEYn4LcmvgxHNUvFCh4GO7AEAgkHL
         6zZP/ko7JCJA2LdoULuNzZRHg0T/8gNViYjoLahQJYHa9eGR53Ki4iiqDtJ36TPMqx
         lIbMd0JkwGNICGQ/kuUhAq6I10OGROfO631v0eeA=
Date:   Wed, 1 Jun 2022 19:05:48 -0400
To:     Frank van der Linden <fllinden@amazon.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Wang Yugui <wangyugui@e16-tech.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Matthew Wilcox <matthew.wilcox@oracle.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: Re: filecache LRU performance regression
Message-ID: <20220601230548.GA29667@fieldses.org>
References: <5C7024DA-A792-4091-BFDE-CEED59BC1B69@oracle.com>
 <20220527203721.GA10628@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <ADD1751A-7F67-4729-BFFC-D6938CA963A0@oracle.com>
 <BED36887-054D-4DC9-A5F1-CB6DD1F0DC16@oracle.com>
 <20220601161003.GA20483@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
 <4C14DB3A-A5C1-41A9-8293-DF4FC2459600@oracle.com>
 <20220601211827.GA11605@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601211827.GA11605@dev-dsk-fllinden-2c-d7720709.us-west-2.amazon.com>
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

On Wed, Jun 01, 2022 at 09:18:27PM +0000, Frank van der Linden wrote:
> A related issue: there is currently no upper limit that I can see
> on the number of active OPENs for a client. So essentially, a
> client can run a server out of resources by doing a very large
> number of OPENs.
> 
> Should there be an upper limit, above which requests are either
> denied, or old state is invalidated?

Could be, if only to prevent abuse.  It doesn't seem to be a problem
people hit in practice, though.

Delegations add a bit of a wrinkle, as they allow the client do do opens
and locks locally without limit, and denying them during recovery from a
delegation break is ugly.

--b.
