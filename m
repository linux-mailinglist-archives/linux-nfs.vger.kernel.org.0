Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA898201C40
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2020 22:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388414AbgFSURF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Jun 2020 16:17:05 -0400
Received: from fieldses.org ([173.255.197.46]:44002 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388032AbgFSURE (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Jun 2020 16:17:04 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 61F1178B3; Fri, 19 Jun 2020 16:17:04 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 61F1178B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1592597824;
        bh=jQVHZcGXq0+ZRMeVMggMWgu/wLlt6OVW78cDj6/dwf0=;
        h=Date:To:Cc:Subject:References:In-Reply-To:From:From;
        b=lL8oeponHev22A0XEuWw/FI+TGQtibQRGm0ifteSy4U90zozdRE/hzUOOBGI4e1BX
         Z4ZyEQ+mxXagMwqat9HCIm3xRoeKbOABXMDbvZC5ajHGynoreGDA1M5mWfc3C2hYza
         xYENDx3qF2nnMoAEPrPRWENPCWVq0SYJ/stqojS4=
Date:   Fri, 19 Jun 2020 16:17:04 -0400
To:     Trishali Nayar <ntrishal@in.ibm.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: Trunking Support in 4.1
Message-ID: <20200619201704.GA1564@fieldses.org>
References: <OF8137F6B8.51CF4CA7-ON0025858B.00459213-6525858B.0052D80D@notes.na.collabserv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8137F6B8.51CF4CA7-ON0025858B.00459213-6525858B.0052D80D@notes.na.collabserv.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jun 18, 2020 at 08:34:53PM +0530, Trishali Nayar wrote:
> Hi all,
> 
> The 4.1 RFC mentions about two types of trunking: Session trunking and 
> Client ID trunking.
>  
> Are both of these supported by 4.1 servers and clients? 
> 
> And are these mandatory features to claim 4.1 support?

They are mandatory for servers to support, and the Linux server supports
them.

The client makes some use of session trunking with the nconnect mount
option.

--b.

> 
> Your insights will be really useful.
>  
> Thanks and regards,
> Trishali.
