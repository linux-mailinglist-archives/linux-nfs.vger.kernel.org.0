Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4B8611527
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 16:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiJ1Ot1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 10:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiJ1OtF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 10:49:05 -0400
X-Greylist: delayed 376 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 28 Oct 2022 07:48:04 PDT
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D111FB7A0
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 07:48:03 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8D5753FCB; Fri, 28 Oct 2022 10:41:46 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8D5753FCB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1666968106;
        bh=3BInrWdPz0qkcKTgqkWhUd29F6unsViZYMA7JT94jUw=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=mGCFbeJnht4oF9/Ctz7ZwygEU+Wm9b4e+rXNN90T416M0uaDIwZF4EkMJNxwipW6h
         9ihWr/HnRPDCLQXap+L2iC+gIF9x/F97ai6EULq09vQMNK2jWay7J0uOCHHTOwHEqH
         ltWpt7Ko25qHlKsyuE20tqqHfpWl9uiTG0CI0oV0=
Date:   Fri, 28 Oct 2022 10:41:46 -0400
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: Fwd: NFS 4 GPF while processing compound with multiple reads
Message-ID: <20221028144146.GA25371@fieldses.org>
References: <CAD15GZfmZYKmGs7GfaUwM1V65uLirgwYBwrvBj7VrUpmFUjOTQ@mail.gmail.com>
 <54463F56-C3EE-431B-9BEE-8B805AD011B9@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54463F56-C3EE-431B-9BEE-8B805AD011B9@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Oct 27, 2022 at 07:12:07PM +0000, Chuck Lever III wrote:
> 
> 
> > Begin forwarded message:
> > 
> > From: Jan Kasiak <j.kasiak@gmail.com>
> > Subject: NFS 4 GPF while processing compound with multiple reads
> > Date: October 27, 2022 at 2:16:36 PM EDT
> > To: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
> > 
> > Hi all,
> > 
> > While writing my own NFS client, I have found a simple test case that
> > triggers a general protection fault on the NFS server.
> > 
> > The NFS 4 compound is: PUT_FH, READ, READ
> > The second read causes the fault.
> > 
> > More information, including how to reproduce the bug is available in
> > the bug tracker: https://bugzilla.linux-nfs.org/show_bug.cgi?id=402
> 
> Bruce, are you interested in applying:
> 
> https://bugzilla.linux-nfs.org/show_bug.cgi?id=402#c2

Applied and pushed out.  (But not actually tested!  Let me know if
there's a problem.)

--b.
