Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 553604933D3
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jan 2022 04:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344322AbiASDy7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jan 2022 22:54:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36552 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343592AbiASDy6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jan 2022 22:54:58 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1AC5D1F37E;
        Wed, 19 Jan 2022 03:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642564497; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XdoXnd0HUB/cNn3SGHkaZ99D4GwMtzsZ5iGBrjzW1go=;
        b=TP/OBeXSpqF4WJvqlEDt+ek6dd2m6D9tH01xo1sqP697jP2TfnPiRzE16RevYgjd6yb0Zz
        7mZDv5vza2wjtZxxWWQ4i8xYPj83YL3fCRqeFWlreMr7i+b3NA8GKVdZ0ZJlIQ5a/2r0MG
        ijOVEw3GVJtKTCqDTev+rPgU1KNITe0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642564497;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XdoXnd0HUB/cNn3SGHkaZ99D4GwMtzsZ5iGBrjzW1go=;
        b=WIuF3FqWdYABX9ZooATX7Q/aGUO1ki+rBwPRnALKJvk94nI5beyygc2CVLVYuQMYFJeM+C
        wgyY8A3osK2n1JCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB73B13419;
        Wed, 19 Jan 2022 03:54:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 093+KI2L52EvGAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 19 Jan 2022 03:54:53 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Christoph Hellwig" <hch@infradead.org>
Cc:     "Trond Myklebust" <trond.myklebust@hammerspace.com>,
        "Anna Schumaker" <anna.schumaker@netapp.com>,
        "Chuck Lever" <chuck.lever@oracle.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "Christoph Hellwig" <hch@infradead.org>,
        "David Howells" <dhowells@redhat.com>, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/18] MM: Add AS_CAN_DIO mapping flag
In-reply-to: <YcGUWxqQts79Kv6B@infradead.org>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>,
 <163969850302.20885.17124747377211907111.stgit@noble.brown>,
 <YcGUWxqQts79Kv6B@infradead.org>
Date:   Wed, 19 Jan 2022 14:54:49 +1100
Message-id: <164256448911.8775.16853022981145854177@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 21 Dec 2021, Christoph Hellwig wrote:
> On Fri, Dec 17, 2021 at 10:48:23AM +1100, NeilBrown wrote:
> > Currently various places test if direct IO is possible on a file by
> > checking for the existence of the direct_IO address space operation.
> > This is a poor choice, as the direct_IO operation may not be used - it is
> > only used if the generic_file_*_iter functions are called for direct IO
> > and some filesystems - particularly NFS - don't do this.
> > 
> > Instead, introduce a new mapping flag: AS_CAN_DIO and change the various
> > places to check this (avoiding a pointer dereference).
> > unlock_new_inode() will set this flag if ->direct_IO is present, so
> > filesystems do not need to be changed.
> > 
> > NFS *is* changed, to set the flag explicitly and discard the direct_IO
> > entry in the address_space_operations for files.
> 
> For other can flags related to file operations we usuall stash them into
> file->f_mode.  Any reason to treat this different?

f_mode is a much better place to put the flag!  Thanks for that
suggestion and all the other feedback.  I'll post a new series early
next week.

Thanks,
NeilBrown
