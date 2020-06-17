Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B4BA1FCE60
	for <lists+linux-nfs@lfdr.de>; Wed, 17 Jun 2020 15:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgFQN2P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 17 Jun 2020 09:28:15 -0400
Received: from fieldses.org ([173.255.197.46]:43844 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgFQN2P (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 17 Jun 2020 09:28:15 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8E91A1C81; Wed, 17 Jun 2020 09:28:14 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 8E91A1C81
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592400494;
        bh=RDkB/dbveNOEMeJtSNG7PSta0jcd/YziMR793o3t2j8=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=ZuDnC2o+RcWWZagJ4q8G6+LCCRXgoYOKkQ4d1wzTMa1FjljWfIw9iU8H9jAYO5wcB
         hvDLRoEZH7BaxEh3tFHybuzexB6lz+Qwoz0sFceuC37nkdR6S6ZGZ3H/CBfXTwcTpl
         DNuab5KUxwlCIcShVU4xf63Zj3kMt+Jm24TAjhto=
Date:   Wed, 17 Jun 2020 09:28:14 -0400
To:     Trishali Nayar <ntrishal@in.ibm.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: ACL's on 4.1
Message-ID: <20200617132814.GA13815@fieldses.org>
References: <OF7A07A04B.B2FBC2B0-ON00258589.004D5BD3-65258589.004D7269@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF7A07A04B.B2FBC2B0-ON00258589.004D5BD3-65258589.004D7269@notes.na.collabserv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 16, 2020 at 07:35:55PM +0530, Trishali Nayar wrote:
> Hi all,
> 
> Looking at the 4.1 RFC, there are some additional 'Access_mask' and 
> 'Ace-flag' when compared to 4.0.
>  
> - Access_mask:
> ACE4_WRITE_RETENTION
> ACE4_WRITE_RETENTION_HOLD
> 
> - Ace-flag :
> ACE4_INHERITED_ACE
>  
> But are these supported by 4.1 clients and servers?

These are optional.  Linux knfsd does not support them.  I'm not sure
what if any servers do.  If someone was interested in adding client-side
support, it would probably not be hard to add it to nfs4-acl-tools.

--b.

> If you do 'man 
> nfs4_acl' it does not seem to show these additional ones. So how do we 
> set/get them?
> 
> Also, are there any other differences from an ACL perspective between 4.0 
> and 4.1?
>  
> Your insights will be really useful.
>  
> Thanks and regards,
> Trishali.
