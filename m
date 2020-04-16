Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEC51AC605
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Apr 2020 16:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410132AbgDPO2u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Apr 2020 10:28:50 -0400
Received: from fieldses.org ([173.255.197.46]:51266 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410120AbgDPO2r (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 16 Apr 2020 10:28:47 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 313741510; Thu, 16 Apr 2020 10:28:45 -0400 (EDT)
Date:   Thu, 16 Apr 2020 10:28:45 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: GSS unwrapping breaks the DRC
Message-ID: <20200416142845.GA28206@fieldses.org>
References: <DAED9EC8-7461-48FF-AD6C-C85FB968F8A6@oracle.com>
 <20200415192542.GA6466@fieldses.org>
 <0775FBE7-C2DD-4ED6-955D-22B944F302E0@oracle.com>
 <20200415215823.GB6466@fieldses.org>
 <39815C35-EAD8-4B2E-B48F-88F3D5B10C57@oracle.com>
 <20200416000009.GA13083@fieldses.org>
 <B6923717-3396-4DC2-AD63-1C5797B2471C@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B6923717-3396-4DC2-AD63-1C5797B2471C@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 16, 2020 at 10:07:27AM -0400, Chuck Lever wrote:
> The bigger picture is updating the server to use xdr_stream throughout
> its XDR stack. That's the main reason I worked on the client-side GSS
> wrap and unwrap functions last year.
> 
> Using xdr_stream would move the server and client sides closer together
> in style and implementation, then hopefully we could share more code.

I'm all for that, though I'm not sure it's the same problem.

The krb5i/krb5p implementation isn't based on xdr_stream on either the
client or the server.

But yes maybe it would force thinking about what the different xdr_buf
fields mean in a way that would clarify things.  I don't know.

--b.
