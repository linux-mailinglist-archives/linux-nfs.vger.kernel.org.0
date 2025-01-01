Return-Path: <linux-nfs+bounces-8862-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF3D9FF507
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 22:46:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2A911882341
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Jan 2025 21:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24C2238382;
	Wed,  1 Jan 2025 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b="fqulKAuQ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from poldevia.fieldses.org (poldevia.fieldses.org [172.234.196.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CD18AFC
	for <linux-nfs@vger.kernel.org>; Wed,  1 Jan 2025 21:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.234.196.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735768001; cv=none; b=OXqa3VF/4zX4H/xQaBj0pV9Dw81bLCvgHvSE0zRyncGIQcK2KyWXp1og22sOALzyy+yHo9hGiVoCr+/1LkNucE1mFZQRlO9X/sWJjc71og8qqbKmRZPcXksgtGaJwNE91Jc6cjwKPswk9Axs3auIBCkh9EZXVX7Ta4Z2w7rRykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735768001; c=relaxed/simple;
	bh=Hxb1qGCHWaS279tpQ0CDIKZw3AMQnIqHNgyDSl77xAw=;
	h=Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To:From; b=NgPEhTErPNsilQibfx3q+CkUkZYNc26Oy0q/494x+mxxyLNTNOsucZLqKPRdfNTqyK7Vpzs+ETZtFhIxUcCjqQYJp7vSlPlqtPy78oc9Hf51bPhASBAKShltKQHSDLJiu+W03Hs3c31IOTizK+daOiidvg/AN5LfnH9YOXBYh2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org; spf=pass smtp.mailfrom=fieldses.org; dkim=pass (1024-bit key) header.d=fieldses.org header.i=@fieldses.org header.b=fqulKAuQ; arc=none smtp.client-ip=172.234.196.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fieldses.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fieldses.org
Received: by poldevia.fieldses.org (Postfix, from userid 2815)
	id 0D498FAF32; Wed,  1 Jan 2025 16:38:16 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 poldevia.fieldses.org 0D498FAF32
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
	s=default; t=1735767496;
	bh=6NE5jp2KjcpMAufFOlGiPacAFmle1sFIoKB/LxGAZd8=;
	h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
	b=fqulKAuQ0itcXD80u5BqXu/Dba6CdaZk/LPMrPNmPQqmKELat2vbxfpBfhkHJxNx4
	 diyS7EOywEumU5UeO84V42Y2czDp41U1xnqi0mlQnFlbWg8fas0ZHEyvDrUgWz8WzV
	 Z77EiYoSQwgZiu3KJop6Qv6BQgHkWKR5anFC0cec=
Date: Wed, 1 Jan 2025 16:38:16 -0500
To: "Gaikwad, Shubham" <Shubham.Gaikwad1@dell.com>
Cc: "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
	"Godbole, Ajey" <Ajey.Godbole@dell.com>
Subject: Re: Clarification on PyNFS Test Case Behavior for
 st_lookupp.testLink in Versions 4.0 and 4.1
Message-ID: <Z3W1yPzJs1bDQGo5@poldevia.fieldses.org>
References: <MW4PR19MB7103BADC7FC3CBC1B2B8FAA5C40B2@MW4PR19MB7103.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR19MB7103BADC7FC3CBC1B2B8FAA5C40B2@MW4PR19MB7103.namprd19.prod.outlook.com>
From: "J. Bruce Fields" <bfields@fieldses.org>

On Wed, Jan 01, 2025 at 06:28:12AM +0000, Gaikwad, Shubham wrote:
> Hi Bruce/PyNFS team,
> I hope this email finds you well.

Thanks, yes, but I'm not actually maintaining pynfs anymore and I don't
remember who is....

> I am reaching out to seek clarification regarding the PyNFS test case
> 'st_lookupp.testLink' (flag: lookupp, code: LOOKP2a/LKPP1a) included
> in the PyNFS test suite for v4.0 and v4.1. Specifically, I would like
> to understand the expected behavior relating to the error codes for
> this test case.
> 
> In the PyNFS test suite for v4.0, the test case LOOKP2a (located at
> nfs4.0/servertests/st_lookupp.py::testLink) initially checked for the
> error code NFS4ERR_NOTDIR. Subsequently, an update was made to this
> test case to also expect NFS4ERR_SYMLINK in addition to NFS4ERR_NOTDIR
> [reference: git.linux-nfs.org Git - bfields/pynfs.git/commitdiff].
> However, in the PyNFS test suite for v4.1, the corresponding test case
> LKPP1a (located at nfs4.1/server41tests/st_lookupp.py::testLink)
> continues to check only for NFS4ERR_SYMLINK as the expected error
> code.
> 
> Given the discrepancy, should the test case for v4.1 (LKPP1a) be
> updated to also check for NFS4ERR_NOTDIR, similar to the modification
> made for the v4.0 test case (LOOKP2a)? Additionally, while the RFC
> 8881 section on the lookupp operation [reference: Section 18.14:
> Operation 16: LOOKUPP - Lookup Parent Directory] does not explicitly
> mention the error code NFS4ERR_SYMLINK, it is noted in Sections 15.2
> [reference: Operations and Their Valid Errors] and section 15.4
> [reference: Errors and the Operations That Use Them]. Therefore, would
> it be reasonable to update the test case LKPP1a to allow both
> NFS4ERR_SYMLINK and NFS4ERR_NOTDIR as valid error codes, ensuring the
> test case passes if either error code is received from the server?

Not sure!  In theory I guess 4.1 could be stricter about the error code
than 4.0.  Language for other operations (e.g. LOOKUP, 18.13.4) does
seem to prefer ERR_SYMLINK in the case of a symlink.  I think the Linux
client probably only uses LOOKUPP in the export code, where the choice
of error is unlikely to matter.

I'd guess it doesn't matter much.  What motivates the question?

--b.

> 
> Your insight on this matter would be greatly appreciated.
> 
> References: 1. git.linux-nfs.org Git - bfields/pynfs.git/commitdiff --
> https://git.linux-nfs.org/?p=bfields/pynfs.git;a=commitdiff;h=6044afcc8ab7deea1beb77be53956fc36713a5b3;hp=19e4c878f8538881af2b6e83672fb94d785aea33
> 2. Section 18.14: Operation 16: LOOKUPP - Lookup Parent Directory --
> https://www.rfc-editor.org/rfc/rfc8881.html#name-operation-16-lookupp-lookup
> 3. Operations and Their Valid Errors --
> https://www.rfc-editor.org/rfc/rfc8881.html#name-operations-and-their-valid-
> 4. Errors and the Operations That Use Them --
> https://www.rfc-editor.org/rfc/rfc8881.html#name-errors-and-the-operations-t
> 
> Best regards, Shubham Gaikwad

