Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A816EB155B
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 22:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbfILUXx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 16:23:53 -0400
Received: from fieldses.org ([173.255.197.46]:35180 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbfILUXw (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Sep 2019 16:23:52 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 80E142010; Thu, 12 Sep 2019 16:23:52 -0400 (EDT)
Date:   Thu, 12 Sep 2019 16:23:52 -0400
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        bfields@redhat.com, linux-nfs@vger.kernel.org
Subject: Re: [PATCH v6 05/19] NFS: inter ssc open
Message-ID: <20190912202352.GB5054@fieldses.org>
References: <20190906194631.3216-1-olga.kornievskaia@gmail.com>
 <20190906194631.3216-6-olga.kornievskaia@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190906194631.3216-6-olga.kornievskaia@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Sep 06, 2019 at 03:46:17PM -0400, Olga Kornievskaia wrote:
> +static int read_name_gen = 1;
> +#define SSC_READ_NAME_BODY "ssc_read_%d"
> +
...
> +	res = ERR_PTR(-ENOMEM);
> +	len = strlen(SSC_READ_NAME_BODY) + 16;
> +	read_name = kzalloc(len, GFP_NOFS);
> +	if (read_name == NULL)
> +		goto out;
> +	snprintf(read_name, len, SSC_READ_NAME_BODY, read_name_gen++);
...
> +	filep = alloc_file_pseudo(r_ino, ss_mnt, read_name, FMODE_READ,
> +				     r_ino->i_fop);

So, I"m curious: does this "name" ever get used anywhere?  Can you see
it from userspace somehow, for example?  Does it have some debugging
value?  Or could it just be the empty string?

--b.
