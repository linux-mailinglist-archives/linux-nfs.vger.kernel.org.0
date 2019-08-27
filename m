Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FAF69E98F
	for <lists+linux-nfs@lfdr.de>; Tue, 27 Aug 2019 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfH0Ngl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 27 Aug 2019 09:36:41 -0400
Received: from mga07.intel.com ([134.134.136.100]:15517 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbfH0Ngl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 27 Aug 2019 09:36:41 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 06:36:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,437,1559545200"; 
   d="scan'208";a="380919371"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 27 Aug 2019 06:36:39 -0700
Received: from andy by smile with local (Exim 4.92.1)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1i2beI-0004Vo-Ue; Tue, 27 Aug 2019 16:36:38 +0300
Date:   Tue, 27 Aug 2019 16:36:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     "J. Bruce Fields" <bfields@redhat.com>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 08/16] nfsd: escape high characters in binary data
Message-ID: <20190827133638.GE2680@smile.fi.intel.com>
References: <1561042275-12723-1-git-send-email-bfields@redhat.com>
 <1561042275-12723-9-git-send-email-bfields@redhat.com>
 <20190806121931.GA29578@smile.fi.intel.com>
 <20190806185008.GC9456@parsley.fieldses.org>
 <20190807090007.GK30120@smile.fi.intel.com>
 <20190808112844.GB7830@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808112844.GB7830@fieldses.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 08, 2019 at 07:28:44AM -0400, J. Bruce Fields wrote:
> On Wed, Aug 07, 2019 at 12:00:07PM +0300, Andy Shevchenko wrote:

> > In any case regarding to this one, I would like rather to see it's never
> > appeared, or now will be gone in favour of string_escape_mem() extension.
> 
> To be clear, it's already merged.  Apologies, I actually saw your name
> when looking for people to cc, but the last commit was 5 years ago and I
> assumed you'd moved on.  The project to extend string_escape_mem()
> looked more complicated than I first expected so I decided to merge this
> first and then follow up with my attempt at that.

The (main) problem with the new helper is that is missed from %pE point of
view. That's why I really prefer to see new flags rather than new helpers like
that.

-- 
With Best Regards,
Andy Shevchenko


