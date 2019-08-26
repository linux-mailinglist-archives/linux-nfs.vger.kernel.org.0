Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E60589D450
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Aug 2019 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbfHZQqC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Aug 2019 12:46:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729358AbfHZQqC (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Aug 2019 12:46:02 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3687F7F75E;
        Mon, 26 Aug 2019 16:46:02 +0000 (UTC)
Received: from localhost (unknown [10.36.118.55])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D851260BEC;
        Mon, 26 Aug 2019 16:46:01 +0000 (UTC)
Date:   Mon, 26 Aug 2019 18:46:00 +0200
From:   Niels de Vos <ndevos@redhat.com>
To:     "de Vandiere, Louis" <louis.devandiere@atos.net>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: Maximum Number of ACL on NFSv4
Message-ID: <20190826164600.GD28580@ndevos-x270>
References: <AM5PR0202MB25641230B578F7D080A67BA4E7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <AM5PR0202MB2564E6F05627D0EF49D043DFE7A40@AM5PR0202MB2564.eurprd02.prod.outlook.com>
 <85fc5336-416f-2668-c9e2-8474e6e40c33@math.utexas.edu>
 <AM5PR0202MB25644F1290D20A1996C5EED4E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM5PR0202MB25644F1290D20A1996C5EED4E7A10@AM5PR0202MB2564.eurprd02.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.71]); Mon, 26 Aug 2019 16:46:02 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Aug 26, 2019 at 02:53:05PM +0000, de Vandiere, Louis wrote:
> Yes, I assume it's not very frequent to have hundreds of NFSv4 ACLs. For compliance and organizational issue, we cannot use groups efficiently to manage access to the shares, so it's user-based and case by case.
>  
> My real goal is to be able to replicate some files to a new NFSv4 server while preserving the ACLs. By using "cp -R --preserve=all acl-folder/", I'm able to preserve the ACLs when their number does not exceed 200, above it, I see the "File too large" error while rsync does not work at all (even in version 3.1.3). That's why I'm digging into this and checking what possibly could go wrong.

You might be hitting a limit in the filesystem on the NFS server. The
ACLs are stored in extended attributes. Depending on the filesystem, you
may be able to configure larger inode sizes (or other storage for
xattrs). With XFS this can be done with 'mkfs -t xfs -i size=.. ...',

HTH,
Niels


> 
> Thank you.
> Best,
> Louis de Vandière
> 
> 
> -----Original Message-----
> From: Goetz, Patrick G <pgoetz@math.utexas.edu> 
> Sent: Monday, August 26, 2019 8:44 AM
> To: de Vandiere, Louis <louis.devandiere@atos.net>; linux-nfs@vger.kernel.org
> Subject: Re: Maximum Number of ACL on NFSv4
> 
> I'm dying to know what the use case is for this, and why you can't just do this with group permissions (unless you're talking about hundreds of group ACLs).
> 
> On 8/23/19 5:31 PM, de Vandiere, Louis wrote:
> > Hi,
> > 
> > I'm currently trying to apply hundreds of ACLs on file hosted on a NFSv4 server (nfs-utils-1.3.0-0.61.el7.x86_64 and nfs4-acl-tools.0.3.3-19.el7.x86_64). It appears that the limit I can apply is 207. After the limit is reached, the command "nfs4_setfacl -a" returned the error "Failed setxattr operation: File too large". The same problem happens if I use an ACL with more than 200 line in it. I did a little debugging session but I was not able to come up with an explanation on why I'm facing such an issue.
> > 
> > On the other hand, I can apply hundreds of ACLs on XFS without issue. Do you know if it could be a bug with the nfs4-acl-tools package?
> > Thank you for your support.
> > Best,
> > Louis de Vandière
> >>> This message is from an external sender. Learn more about why this <<
> >>> matters at https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flinks.utexas.edu%2Frtyclf&amp;data=02%7C01%7Clouis.devandiere%40atos.net%7Ce6d6b4705cde46bf455a08d72a2b93df%7C33440fc6b7c7412cbb730e70b0198d5a%7C0%7C0%7C637024238975648645&amp;sdata=EgTg3%2BPyIrnqG6axcHOybKZ1AldsGXj8CIC5z0F0Rac%3D&amp;reserved=0.                        <<
> > 
