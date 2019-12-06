Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA07B115876
	for <lists+linux-nfs@lfdr.de>; Fri,  6 Dec 2019 22:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbfLFVPj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 6 Dec 2019 16:15:39 -0500
Received: from fieldses.org ([173.255.197.46]:54238 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbfLFVPi (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 6 Dec 2019 16:15:38 -0500
Received: by fieldses.org (Postfix, from userid 2815)
        id 9B52120A8; Fri,  6 Dec 2019 16:15:38 -0500 (EST)
Date:   Fri, 6 Dec 2019 16:15:38 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     "J. Bruce Fields" <bfields@redhat.com>
Cc:     Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-nfs <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] NFSD: allow inter server COPY to have a STALE
 source server fh
Message-ID: <20191206211538.GC17524@fieldses.org>
References: <20191204080039.ixjqetefkzzlldyt@kili.mountain>
 <CAN-5tyEG3C_Ebdr6dpMJ+gQ1pEAMNqbTv76dKu=KK9rspREr1A@mail.gmail.com>
 <20191204220435.GG40361@pick.fieldses.org>
 <20191205023826.GA43279@pick.fieldses.org>
 <20191206211442.GB17524@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206211442.GB17524@fieldses.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Dec 06, 2019 at 04:14:42PM -0500, bfields wrote:
> On Wed, Dec 04, 2019 at 09:38:26PM -0500, J. Bruce Fields wrote:
> > So, stuff we could do:
> > 
> > 	- add an extra check of fh_export or something here.
> 
> So, I'm applying the following for now.
> +			if (current->fh->fh_export &&
				   ^^^

Um, maybe with a typo or two fixed.


> +					need_wrongsec_check(rqstp))
>  				op->status = check_nfsd_access(current_fh->fh_export, rqstp);
>  		}
>  encode_op:
