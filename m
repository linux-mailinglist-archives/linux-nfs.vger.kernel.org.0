Return-Path: <linux-nfs+bounces-3636-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A359902744
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 18:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E03CB1F22904
	for <lists+linux-nfs@lfdr.de>; Mon, 10 Jun 2024 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE64C757E3;
	Mon, 10 Jun 2024 16:47:11 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A3814658E
	for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718038031; cv=none; b=LpQ+/TmOCeMjXZE1pEczal95JcIeZEpEwHNwN+wfXGOUREIbnKBVDRmk4tzFrWik9WchE2xtf9QsDebeRMPj/GFfD4Kg6EApukpXGDEoSvlXs5nOfLez8x6+KQ6wpbGGA5Ui3xF7L4R6HsFdN8LQ/+OYu2LiM4z4m9/PMTBf0ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718038031; c=relaxed/simple;
	bh=8XQ7Hp8yFQ/7mY9DSgFVzopDpmXttmzU6yG9Lt0Oizw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ajNbJMqD3ECISF3DITvMFBeHJ0yWYGDQs9mNR3wvAUA5CZwOwhAf1Zt7HSUKwk3Rs4uhxdFGmeNY4E5WI0+wJHdi1Hig+Lbg0Rw+1ydxzCOaP7jPIJhsAV2NnYLDblXEHm/lPeyB1lf1uB+kF5w4OzrvoorvMHrgqJbCRTJN5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=snitzer.net; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=snitzer.net
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3c9cc66c649so2460566b6e.1
        for <linux-nfs@vger.kernel.org>; Mon, 10 Jun 2024 09:47:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718038029; x=1718642829;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i1d7LInwUIlgKqXLBs1m/5gMpvyx4D0T8+DDZXIKb/c=;
        b=Pr7+ba6hqN4vF7ttB5gNThYcXFyfMUwN5FhWMjsky/PTu2wexTRBY5k46RoFnf9q7L
         WavRUybsH1Tkrp0TmCI104mP4AcQtI5+BL1z/W8/wMqI75FuLIXWbKVV0oITTcI7TY/i
         MqqB1AARatsGtYNVL2AaEMxmfazA9HrI8lQRkc1NWwnT6RhyU6rJpOPlusn7Ynn+9mCm
         1DbtJQ1UKTKToJBlOq11bd6yC4ANQAxlWXIFqsvl4BiUhen5fUkEd1H01g/HvUouS+Jr
         lpkl2q/mp1ASa5dyhaafzyLKyXdfPiYr4zFYdwSuWswNhFZtWpTmSgiZvko1lQY8uduW
         a2bQ==
X-Gm-Message-State: AOJu0YxKbMhi5nWOckmMIUGy1GeA7vDp/kEGCHVakl0V4+bTuYCMNste
	+hPawUrjH38vs11a7mlkoIb8mDWZjfUKXWIXHnBXZHsFH73HGl1F70ZXBKftK7w=
X-Google-Smtp-Source: AGHT+IGfLw94d59nMbJiidwmz3cva5izg8usQBs7RvWQgSdjR1VF6+kBEE5cRg7c/bmcUyOrJVdcjA==
X-Received: by 2002:a05:6808:10c8:b0:3d2:2512:5a5c with SMTP id 5614622812f47-3d225126108mr4946457b6e.53.1718038028692;
        Mon, 10 Jun 2024 09:47:08 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-795520b3883sm246544085a.50.2024.06.10.09.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 09:47:07 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:47:06 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trondmy@hammerspace.com>, snitzer@hammerspace.com
Subject: Re: [for-6.11 PATCH 00/29] nfs/nfsd: add support for localio bypass
Message-ID: <ZmcuCkpAK3ae3K3c@kernel.org>
References: <20240607142646.20924-1-snitzer@kernel.org>
 <fa2a9dd7770877781e82fa1e4e2d7a0e3652c106.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa2a9dd7770877781e82fa1e4e2d7a0e3652c106.camel@kernel.org>

On Mon, Jun 10, 2024 at 08:47:47AM -0400, Jeff Layton wrote:
> On Fri, 2024-06-07 at 10:26 -0400, Mike Snitzer wrote:
> > Hi,
> > 
> > This patch series rebases "localio" changes that Hammerspace (and
> > Primary Data before it) has been carrying since 2014. The reason they
> > weren't proposed for upstream inclusion until now was the handshake
> > for whether or not a client and server are local was brittle. Please
> > see the commit header of "nfs/localio: discontinue network address
> > based localio setup" (patch 20) for more context.
> > 
> > Aside from rebasing the original changes (patches 1 - 18) from a
> > 5.15.-130-stable kernel, my contribution to this series was to make
> > the localio handshake more robust. To do so a new LOCALIO protocol
> > extension has been added to both NFS v3 and v4. It follows the
> > well-worn pattern established by the ACL protocol extension.
> > 
> > These changes have proven stable against various test scenarios:
> > 1) client and server both on localhost (for both v3 and v4.2)
> > 2) various permutations of client and server support enablement for
> >    both local and remote client and server.
> > 3) client on host, server within a container (for both v3 and v4.2)
> > 
> > I've preserved all established author and Signed-off-by attribution
> > despite Andy, Peng and Jeff no longer working for Primary Data (or
> > Hammerspace). I've confirmed with Trond that its best to keep it all
> > despite those email addresses no longer being active. My Signed-off-
> > by
> > and that of reviewers and maintainer(s) to follow will build on the
> > established development provenance.
> >
> > I also made sure to preserve the original work done by others (rather
> > than fold changes that I add to this work, to avoid tainting the long
> > established development and sequence of changes).
> > 
> 
> Honestly, I don't give a fig about the historical changes here. I'd
> _much_ rather see a more logical folded patchset that avoids a lot of
> the "churn". Given the long timescale of this series, the history is
> just not terribly useful.

Fair, will do (and this answers the question I just asked in response
to a different patch).
 
> For instance, you're adding in the old network address tracking in the
> earlier patches and then remove that in patch #20, which just means I
> have to review a bunch of stuff that is ultimately going away. I'll
> still review the set you've posted, but I think folding down the
> changes would be best.

Yeah, I just wanted to not be excessive with folding patches -- purely
to preserve the evolution of these changes (given the different
authors, etc).  But I agree with you, and will sort it out for v2.

Mike

