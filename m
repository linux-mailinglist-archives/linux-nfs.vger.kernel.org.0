Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B163CEFCC
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Jul 2021 01:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236504AbhGSWpx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Jul 2021 18:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358128AbhGSTTe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 19 Jul 2021 15:19:34 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31D3C061574;
        Mon, 19 Jul 2021 12:54:00 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 8EE5161D7; Mon, 19 Jul 2021 16:00:03 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8EE5161D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1626724803;
        bh=b9qm4hKOOAHjad+oiXzxEcT+dT1CknWHrSBYAfAxuic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J1SSzSUzI9styPoMp40SP4m4ZHLIfWaV5z0IFTOz+2vpWnsE5PEhDXFEMw4IYsv6a
         dfRcxkoku2k7Pb5VS74LQDmC4HrIsSZWxMeOv41hb8Az7/4A1Q6MK9fKvwShPKOQ77
         HcRfi0sroeqwC19rSOzdECIWkbDOVEodwkCoukSY=
Date:   Mon, 19 Jul 2021 16:00:03 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     NeilBrown <neilb@suse.de>, Christoph Hellwig <hch@infradead.org>,
        Chuck Lever <chuck.lever@oracle.com>, Chris Mason <clm@fb.com>,
        David Sterba <dsterba@suse.com>, linux-nfs@vger.kernel.org,
        Wang Yugui <wangyugui@e16-tech.com>,
        Ulli Horlacher <framstag@rus.uni-stuttgart.de>,
        linux-btrfs@vger.kernel.org
Subject: Re: [PATCH/RFC] NFSD: handle BTRFS subvolumes better.
Message-ID: <20210719200003.GA32471@fieldses.org>
References: <20210613115313.BC59.409509F4@e16-tech.com>
 <20210310074620.GA2158@tik.uni-stuttgart.de>
 <162632387205.13764.6196748476850020429@noble.neil.brown.name>
 <edd94b15-90df-c540-b9aa-8eac89b6713b@toxicpanda.com>
 <YPBmGknHpFb06fnD@infradead.org>
 <28bb883d-8d14-f11a-b37f-d8e71118f87f@toxicpanda.com>
 <YPBvUfCNmv0ElBpo@infradead.org>
 <e1d9caad-e4c7-09d4-b145-5397b24e1cc7@toxicpanda.com>
 <162638862766.13764.8566962032225976326@noble.neil.brown.name>
 <15d0f450-cae5-22bc-eef3-8a973e6dda27@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15d0f450-cae5-22bc-eef3-8a973e6dda27@toxicpanda.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Jul 19, 2021 at 11:40:28AM -0400, Josef Bacik wrote:
> Ok so setting aside btrfs for the moment, how does NFS deal with
> exporting a directory that has multiple other file systems under
> that tree?  I assume the same sort of problem doesn't occur, but why
> is that?  Is it because it's a different vfsmount/sb or is there
> some other magic making this work?  Thanks,

There are two main ways an NFS client can look up a file: by name or by
filehandle.  The former's the normal filesystem directory lookup that
we're used to.  If the name refers to a mountpoint, the server can cross
into the mounted filesystem like anyone else.

It's the lookup by filehandle that's interesting.  Typically the
filehandle includes a UUID and an inode number.  The server looks up the
UUID with some help from mountd, and that gives a superblock that nfsd
can use for the inode lookup.

As Neil says, mountd does that basically by searching among mounted
filesystems for one with that uuid.

So if you wanted to be able to handle a uuid for a filesystem that's not
even mounted yet, you'd need some new mechanism to look up such uuids.

That's something we don't currently support but that we'd need to
support if BTRFS subvolumes were automounted.  (And it might have other
uses as well.)

But I'm not entirely sure if that answers your question....

--b.
