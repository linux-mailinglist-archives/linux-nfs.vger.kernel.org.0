Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE75AA3D48
	for <lists+linux-nfs@lfdr.de>; Fri, 30 Aug 2019 19:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfH3R4J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 30 Aug 2019 13:56:09 -0400
Received: from fieldses.org ([173.255.197.46]:51154 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727304AbfH3R4J (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 30 Aug 2019 13:56:09 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id BA6E3BD8; Fri, 30 Aug 2019 13:56:08 -0400 (EDT)
Date:   Fri, 30 Aug 2019 13:56:08 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     "J. Bruce Fields" <bfields@redhat.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v5 5/9] NFSD add COPY_NOTIFY operation
Message-ID: <20190830175608.GA5053@fieldses.org>
References: <20190808201848.36640-1-olga.kornievskaia@gmail.com>
 <20190808201848.36640-6-olga.kornievskaia@gmail.com>
 <CAN-5tyF6ZMf_jiKycK1rk9v7xATDb=j_e5d0QBp9LOgdvn-utA@mail.gmail.com>
 <CAN-5tyEyvjJB+4_bKZmEYhv2KrVvk7dDvF27i6mx4naDt33Nww@mail.gmail.com>
 <20190812200019.GB29812@parsley.fieldses.org>
 <CAN-5tyFpHHsH3n8u+qGyp7POdSRHesiKgd3-YQoE9jJSPBVYRw@mail.gmail.com>
 <CAN-5tyEX=4pfntZudpfkN9Pr9OpZfpvKj+NyT-bBD9YJ5fsg7Q@mail.gmail.com>
 <CAN-5tyHOr+0WVthzu6G9qOwaVG0R+yUpuh2iyaTpBkw_O5XGAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAN-5tyHOr+0WVthzu6G9qOwaVG0R+yUpuh2iyaTpBkw_O5XGAA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 29, 2019 at 03:23:43PM -0400, Olga Kornievskaia wrote:
> I'm stuck again. The idea that Trond gave me is to instead of storing
> the pointer to the stateid, (copy) store the stateid_t structure
> itself and then use it to look it up the appropriate nfs4_stid.
> 
> The problem with that is when nfsd4_lookup_stateid() is called it
> takes is a compound state (cstate) which has a client pointer and
> during the lookup it's verified that the client looking up the stateid
> is the same that generate the stateid which is not the case with copy
> offload.
> 
> I tried also saving a cl_clientid and using that to lookup the
> nfs4_client that's needed for the stateid lookup but I'm not sure
> that's possible. lookup_clientid() calls find_client_in_id_table() and
> always passes "false" for sessions args. Original client has minor
> version 2 and then the check if (clp->minor_versions != sessions)
> fails. I don't understand what this logic is suppose to check.
> 
> Should I be writing special version of the lookup_clientid that
> ignores that check (when called in the path of the copy_notify
> verification)? Or any other ideas of how to get passed this would be
> appreciated it.

Yeah, I think you may want to do the clientid lookup by hand under
cl_lock, and take the cl_ref?

Or turn things around and ensure that copy stateid's are destroyed
before clients are.

--b.
