Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9541C215CD9
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2020 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729503AbgGFRSI (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Jul 2020 13:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729478AbgGFRSI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Jul 2020 13:18:08 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B82C061755
        for <linux-nfs@vger.kernel.org>; Mon,  6 Jul 2020 10:18:08 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id DABAA153E; Mon,  6 Jul 2020 13:18:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org DABAA153E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1594055884;
        bh=DyguAXLA+fe1ltd6naPpMwDFvMwlwoEyb3J/SrCoMUc=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=N2RiH3Z5XXg1+O2J5PMhFSQnNzYAG4gFV+A8lbH2beylR0H8kuu9Xy/wv3sXQiZG8
         Ze9JLKMJzTKsFK5EIx2c5p2AE2tOiQaniGCK+HkiekcoPPlSc02NrfBHpMct/kuKlG
         Spxso3Kbr/6MYt430If5qIphlPgJ+U7qcmFksA8s=
Date:   Mon, 6 Jul 2020 13:18:04 -0400
To:     Felix Rubio <felix@kngnt.org>
Cc:     Dai Ngo <dai.ngo@oracle.com>, linux-nfs@vger.kernel.org
Subject: Re: kerberized NFSv4 client reporting operation not permitted when
 mounting with sec=sys
Message-ID: <20200706171804.GA31789@fieldses.org>
References: <0593b4af8ca3fafbec59655bbb39d2b4@kngnt.org>
 <9e25861022acb796c35d3adb392bf4c4@kngnt.org>
 <c058f370-9f7c-146d-e7e6-a3f88b62cbc4@oracle.com>
 <4097833.BOCuNxM56l@polaris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4097833.BOCuNxM56l@polaris>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 02, 2020 at 07:52:41PM +0200, Felix Rubio wrote:
> Your guess is absolutely correct: Right after I send the mail, I noted that... I set it the /exports (fsid=0) to sec=*sys:*krb5:krb5i:krb5p, and then I set the depending FS to the options I wanted: fixed. I even told Benjamin Coddington, out of the happines for having solved it (it was really making me go nuts), but I forgot to tell the mailing list. Sorry for that!

Note, by the way, that fsid=0 thing was required for nfsv4 exports years
ago, but no longer is.  It's usually better not to bother with that.

--b.
