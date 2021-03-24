Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8E96346F03
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 02:47:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbhCXBr0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 21:47:26 -0400
Received: from smtp-fw-9103.amazon.com ([207.171.188.200]:30436 "EHLO
        smtp-fw-9103.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhCXBrR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 23 Mar 2021 21:47:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1616550437; x=1648086437;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yru4cZYSXHFe3Epzftgw0uYtzR/zz5/kotLVlvodWBA=;
  b=wGysh0ASbQocM2XM2+XBoDqv2jM2As1eu6sIOxPKFqD3OXCSuOauTEqR
   cXOZ+wtdSna4yY2KRqkdthjrPgQAfBLnEHYK6sG1sPN256g96mjpUEns6
   JpJBNPEMnguSTJY4mtYJFWF6Q0DcSVnBeuLkBcQfPXhr1tJzvbmxs7QZX
   c=;
X-IronPort-AV: E=Sophos;i="5.81,272,1610409600"; 
   d="scan'208";a="921026729"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-9103.sea19.amazon.com with ESMTP; 24 Mar 2021 01:47:16 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id E06A9A1CC5;
        Wed, 24 Mar 2021 01:47:15 +0000 (UTC)
Received: from EX13D13UWB003.ant.amazon.com (10.43.161.233) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 24 Mar 2021 01:47:15 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D13UWB003.ant.amazon.com (10.43.161.233) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Wed, 24 Mar 2021 01:47:15 +0000
Received: from dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com
 (10.200.231.78) by mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Wed, 24 Mar 2021 01:47:14 +0000
Received: by dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com (Postfix, from userid 5408343)
        id E89EB1EE9; Wed, 24 Mar 2021 01:47:14 +0000 (UTC)
Date:   Wed, 24 Mar 2021 01:47:14 +0000
From:   Geert Jansen <gerardu@amazon.com>
To:     Chuck Lever III <chuck.lever@oracle.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: RFC: return d_type for non-plus READDIR
Message-ID: <20210324014713.GA44499@gerardu>
References: <20210323010057.GA129497@dev-dsk-gerardu-1d-3da90cb4.us-east-1.amazon.com>
 <689DD4DF-17C0-4776-BE53-7F10F7FFE720@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <689DD4DF-17C0-4776-BE53-7F10F7FFE720@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Mar 23, 2021 at 03:26:02PM +0000, Chuck Lever III wrote:

> > Since not all file servers may be able to produce the directory entry type
> > efficiently, this could be implemented as a mount option that defaults off.
> 
> Can you say more about the impact of requesting this attribute
> from servers that cannot efficiently provide it? Which servers
> and filesystems find it a problem, and how much of a problem is
> it?

The ability to satisfy a non-plus READDIR by reading just the directory
pages, instead of having to read all dirent inodes as well, can be worth it
for certain use cases (especially those with large directories). If a file
system does not store d_type in the directory, and the client would always
request the type attribute even for non-plus READDIR, then you lose the
ability to make this optimization.

From a review of the man pages, most local file systems appear to be able to
store d_type within the directory, including ext4, xfs and zfs. Both ext4
and xfs have options to turn this behavior off. If you'd export such a file
system using nfsd, then this would cause additional IO on the file system if
we would always request the type attribute.

I do not know how other commercial servers handle this.

> I'd rather avoid adding another administrative knob unless it is
> absolutely necessary... are there other options for controlling
> whether the client requests this attribute?
> 
> For example, is there a way for a server to decide not to provide
> it if it would be burdensome to do so? ie, the client always asks,
> but it would be up to the server to provide it if it can do so.

I looked in the RFCs but I am not sure if there is a way today? Both 4.0 and
4.1 define "type" as a required attribute that needs to be returned if the
client asks for it. There also does not appear to be an enum value
corresponding to DT_UNKNOWN. Were you thinking about something specifically?

If there's no way to do this today, then I guess a per-file system attribute
that indicates support for "can produce file type efficient when reading a
directory" would would be a relatively clean solution. I presume it would
require an RFC to define this attribute. Would you have a recommendation given
your your experience with the RFC process?

Geert
