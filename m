Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5D6283704
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Oct 2020 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725960AbgJENyx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Oct 2020 09:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgJENyx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 5 Oct 2020 09:54:53 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0994C0613CE
        for <linux-nfs@vger.kernel.org>; Mon,  5 Oct 2020 06:54:53 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BC4F74F3B; Mon,  5 Oct 2020 09:54:52 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org BC4F74F3B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1601906092;
        bh=q9d6CIgzbrNWQX4IwuxyylN/9cKoCvKoLGmYBNEDX+M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gxYCT/nbgPgiMESf3gFUBh+ZB/vms/o4CCqxWDIyUDSbH+CDpShzUaKEyFgJwxjEG
         tUq8mzhrSynQJDm4ZdhvFiv30yuUBxxXf00IRjtO/z1HJerdE8Ipe2fJQ9c6jw98Z2
         TNxkKNxJpJJ4OHVDcGAZrG6ZlJMQB1rNSpVWoRTc=
Date:   Mon, 5 Oct 2020 09:54:52 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Patrick Goetz <pgoetz@math.utexas.edu>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: rpcbind redux
Message-ID: <20201005135452.GD31739@fieldses.org>
References: <6b0c5514-ebb1-fde7-abba-7f4130b3d59f@math.utexas.edu>
 <20201001183036.GD1496@fieldses.org>
 <f621c004-3402-09d0-b2d0-83d610525a7c@math.utexas.edu>
 <20201001200603.GH1496@fieldses.org>
 <2df155d8-2f0b-c113-5244-a09bbea370b3@math.utexas.edu>
 <20201001214344.GJ1496@fieldses.org>
 <5eae41f5-aa78-5cf4-5e39-8b39f1235a65@math.utexas.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eae41f5-aa78-5cf4-5e39-8b39f1235a65@math.utexas.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Oct 02, 2020 at 10:12:24AM -0500, Patrick Goetz wrote:
> I think what you're saying is that I need to add $RPCMOUNTDARGS to
> the service file command line for rpc.nfsd?

Somehow you just need to make sure rpc.nfsd is also getting "-N 2 -N 3"
added to its commandline.  I'm not sure of the right way to do that with
Debian's configuration.

--b.
