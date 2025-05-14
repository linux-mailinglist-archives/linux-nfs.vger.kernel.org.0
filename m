Return-Path: <linux-nfs+bounces-11727-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E47D5AB782A
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 23:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 721D1173419
	for <lists+linux-nfs@lfdr.de>; Wed, 14 May 2025 21:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB192F22;
	Wed, 14 May 2025 21:49:16 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from neil.brown.name (neil.brown.name [103.29.64.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D622222B6
	for <linux-nfs@vger.kernel.org>; Wed, 14 May 2025 21:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.29.64.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747259355; cv=none; b=L8RDRtSYC3QP1VHR5SBqscuZmDMeK6MzCWqSMNKYmqo22K6mymXs+WBaqhy77rGSjOgKmx44cXykFvGZadveWyI8GSV7WvxXA/1cYL+mZxgyAIVpVinyydYsxTYp84CrnaA+RYn+KnKk+DApTYBdLqAKlfYQ3TTQmBuNxZP/RsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747259355; c=relaxed/simple;
	bh=qBv0tPix7yEeknZ/FeVdvDWd76W34SU7CuchIsIBlgU=;
	h=Content-Type:MIME-Version:From:To:Cc:Subject:In-reply-to:
	 References:Date:Message-id; b=b1pKAzQALWHmUgppA/LYpFHWds/6ftRX7dKM91ZRfJc3Rid/DJidP2ZgpqvdhADyKOEF9yKMM59zK1qEASzURoFIwl1RO9qSKBG7CVZh8ZQ0PP1BvyVcygfuw/Eui9FiwxIAn8t3TCY4Scv7SJd3qGL2vp43HDdsqlzL+Gtjpzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name; spf=pass smtp.mailfrom=neil.brown.name; arc=none smtp.client-ip=103.29.64.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=neil.brown.name
Received: from 196.186.233.220.static.exetel.com.au ([220.233.186.196] helo=home.neil.brown.name)
	by neil.brown.name with esmtp (Exim 4.95)
	(envelope-from <mr@neil.brown.name>)
	id 1uFJyR-0048wL-DY;
	Wed, 14 May 2025 21:49:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "NeilBrown" <neil@brown.name>
To: "Thomas Haynes" <loghyr@gmail.com>
Cc: "Jeff Layton" <jlayton@kernel.org>, "Steve Dickson" <steved@redhat.com>,
 linux-nfs@vger.kernel.org
Subject:
 Re: [PATCH nfs-utils] exportfs: make "insecure" the default for all exports
In-reply-to: <6E05B8C0-79E5-4BEA-B177-072792644C1B@gmail.com>
References: <>, <6E05B8C0-79E5-4BEA-B177-072792644C1B@gmail.com>
Date: Thu, 15 May 2025 07:49:11 +1000
Message-id: <174725935122.62796.16690102995427519467@noble.neil.brown.name>

On Wed, 14 May 2025, Thomas Haynes wrote:
> 
> > On May 13, 2025, at 10:16 PM, NeilBrown <neil@brown.name> wrote:
> > 
> > On Tue, 13 May 2025, Jeff Layton wrote:
> >> Back in the 80's someone thought it was a good idea to carve out a set
> >> of ports that only privileged users could use. When NFS was originally
> >> conceived, Sun made its server require that clients use low ports.
> >> Since Linux was following suit with Sun in those days, exportfs has
> >> always defaulted to requiring connections from low ports.
> >> 
> >> These days, anyone can be root on their laptop, so limiting connections
> >> to low source ports is of little value.
> > 
> > But who is going to export any filesystem to their laptop?
> > 
> >> 
> >> Make the default be "insecure" when creating exports.
> > 
> > So you want to break lots of configurations that are working perfectly
> > well?
> > 
> > I don't see any really motivation for this change.  Could you provide it
> > please?
> 
> 
> Consider a pNFS Flex File deployment with 1000s of data servers. The
> metadata server needs access to each data server. If it needs to be on
> a secure port, then the metadata server can easily run out of room.
> 

What is the cost of specifying "insecure" on each export line?

If this really is a burden, I suggest adding a "default-export-options"
or similar to /etc/nfs.conf.  Then you can put 
    default-export-options = secure
in your /etc/nfs.conf and be happy.

Thanks,
NeilBrown

