Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDA648385D
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jan 2022 22:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiACVca (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jan 2022 16:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiACVca (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jan 2022 16:32:30 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEEDCC061761
        for <linux-nfs@vger.kernel.org>; Mon,  3 Jan 2022 13:32:29 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 29CA35FFF; Mon,  3 Jan 2022 16:32:29 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 29CA35FFF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1641245549;
        bh=lCahynYwMpJIERC0nf/icp6k9guu1Gy/YE5JP+wisLM=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=M/VLjdvph2tGbekkilDGt4kcx1nllx9Dj0N8M2Ti+Z/4ClRAUOhD7l1uHhRtRXyQ6
         BB5v4FUanMbmDxMjg9u5+N/7QnWkGFGeS6l68c3eIarurGdj194zi4ic/Z8zre3m+g
         Ywd0z3j2dnfCWh+pXWFzCGTR6yrdSsuUiVVw7cKk=
Date:   Mon, 3 Jan 2022 16:32:29 -0500
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "Dorian Taylor (Lists)" <lists@doriantaylor.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: GSSAPI as it relates to NFS
Message-ID: <20220103213229.GL21514@fieldses.org>
References: <234CDB6C-C565-4BB4-AE38-92F4B05AB4BD@doriantaylor.com>
 <48DBBF53-7CE3-4DDA-B697-B14F8C382E78@oracle.com>
 <AF7243DE-250E-4CCB-86C0-40C69BB71C88@doriantaylor.com>
 <9DA49FE9-F4AF-44CC-8BCF-86F4D2D984AA@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9DA49FE9-F4AF-44CC-8BCF-86F4D2D984AA@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Dec 25, 2021 at 10:53:33PM +0000, Chuck Lever III wrote:
> IIRC Linux requires that a mount operation be done by root. If you run
> gssd with "-n", become root, then kinit as yourself, I think it should
> work.
> 
> There has been some discussion about enabling a non-privileged user to
> perform a mount... it's a bit tricky because the function of mount is
> to alter the file namespace, which traditionally requires extra
> privilege to do.

The core VFS code is quite happy to allow you to make unprivileged
mounts in your own namespace, but the particular filesystem being
mounted also gets a veto.

I think we're expecting NFS will be patched to allow unprivileged mounts
some time.  See e.g.

	https://lore.kernel.org/linux-nfs/aec219339d8296b7e9b114d9d247a71fd47423c5.camel@hammerspace.com/

--b.
