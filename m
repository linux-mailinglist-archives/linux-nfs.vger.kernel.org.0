Return-Path: <linux-nfs+bounces-3074-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 982988B77B9
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 15:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5549E2845C4
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Apr 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4533AC16;
	Tue, 30 Apr 2024 13:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QRObGC7y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75536171E45
	for <linux-nfs@vger.kernel.org>; Tue, 30 Apr 2024 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485497; cv=none; b=B5EEFRnoaoNSy5HKEVmWNQkgOB82d0jL1yWT3YKKPJo2rbPKpy5jadEYtcqIl6i0lZUWZIjNEMECMIkkuWdviGkja5za17qT15wNht5/eKYhCGrckN7evCLCCpor76woGYKjWCSilaglQTghvE5N2Yvmh9thNbMx3UEtGwrBPcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485497; c=relaxed/simple;
	bh=OGgPvpOMkvuOBxBpj6FYHdfg2VxaauUnet7njuyAn9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO6yYIfU50NFgyYT3jGIhO6FHpCAdIugTThjhImwdVYt0IqcfcmbltoH0LenlsO7s9+lvzewkbfocIl0GNi+D2irgtoBc2RiVEfmQ5+SB5wsxyBHZza/IQZwa6LlR/03owfjNqeWY8fPSZ71uL3iPCGqg/KOgf+2kwIqRW9X9C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QRObGC7y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485495;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qbAciLeLTCBdTqrcduQYSBELewIvhU+8/KyBIYk2KhM=;
	b=QRObGC7yxqiA7UcL2ywVgswBUT38bpE/KLrlBMYtCTFNqQTlJkEeDLyi3YofNr19rEj9qo
	62v5vuhxm3yVC3ryHgcBV3ctF6B8PYs1IjeWsYV0lzBGcvb+/2rri4r47dv0iy27qrtDEx
	DsO1rNAtZuMoXiaZSiO/tah8Hw+6yOw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-QO1trRxmN1ujv-IICE0LuA-1; Tue, 30 Apr 2024 09:58:09 -0400
X-MC-Unique: QO1trRxmN1ujv-IICE0LuA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9278812C5A;
	Tue, 30 Apr 2024 13:58:08 +0000 (UTC)
Received: from aion.redhat.com (unknown [10.22.16.67])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CAFEC492BC7;
	Tue, 30 Apr 2024 13:58:08 +0000 (UTC)
Received: by aion.redhat.com (Postfix, from userid 1000)
	id 7674A149E54; Tue, 30 Apr 2024 09:58:08 -0400 (EDT)
Date: Tue, 30 Apr 2024 09:58:08 -0400
From: Scott Mayhew <smayhew@redhat.com>
To: David Gow <davidgow@google.com>
Cc: brendanhiggins@google.com, rmoar@google.com, npache@redhat.com,
	linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH] kunit: bail out early in __kunit_test_suites_init() if
 there are no suites to test
Message-ID: <ZjD48CpjXPsmjU5c@aion>
References: <CAA1CXcBqcyXma1kGwvfAQ5T24dmuH_Or9RPrVqxDoVq=N4Se3w@mail.gmail.com>
 <20240321143200.1854489-1-smayhew@redhat.com>
 <CABVgOSmDJpU7km5em_WbY1A04f+AF74a8_4GccjrJk1nW+1Fww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmDJpU7km5em_WbY1A04f+AF74a8_4GccjrJk1nW+1Fww@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Sat, 23 Mar 2024, David Gow wrote:

> On Thu, 21 Mar 2024 at 22:32, Scott Mayhew <smayhew@redhat.com> wrote:
> >
> > Commit c72a870926c2 added a mutex to prevent kunit tests from running
> > concurrently.  Unfortunately that mutex gets locked during module load
> > regardless of whether the module actually has any kunit tests.  This
> > causes a problem for kunit tests that might need to load other kernel
> > modules (e.g. gss_krb5_test loading the camellia module).
> >
> > So check to see if there are actually any tests to run before locking
> > the kunit_run_lock mutex.
> >
> > Fixes: c72a870926c2 ("kunit: add ability to run tests after boot using debugfs")
> > Reported-by: Nico Pache <npache@redhat.com>
> > Signed-off-by: Scott Mayhew <smayhew@redhat.com>
> > ---
> 
> Thanks, this works well here, and is a good idea anyway.
> 
> Reviewed-by: David Gow <davidgow@google.com>
> 

Brendan, David,

Is there a reason this patch hasn't been merged?

-Scott

> Cheers,
> -- David
> 
> >  lib/kunit/test.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/lib/kunit/test.c b/lib/kunit/test.c
> > index 1d1475578515..b8514dbb337c 100644
> > --- a/lib/kunit/test.c
> > +++ b/lib/kunit/test.c
> > @@ -712,6 +712,9 @@ int __kunit_test_suites_init(struct kunit_suite * const * const suites, int num_
> >  {
> >         unsigned int i;
> >
> > +       if (num_suites == 0)
> > +               return 0;
> > +
> >         if (!kunit_enabled() && num_suites > 0) {
> >                 pr_info("kunit: disabled\n");
> >                 return 0;
> > --
> > 2.43.0
> >



