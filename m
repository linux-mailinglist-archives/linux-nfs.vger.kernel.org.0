Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 121B978D05
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Jul 2019 15:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbfG2NlE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Jul 2019 09:41:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35900 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726962AbfG2NlD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 29 Jul 2019 09:41:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id z4so59720902qtc.3
        for <linux-nfs@vger.kernel.org>; Mon, 29 Jul 2019 06:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yXQY60O0HoTWVAfqCbGzOZIz9/numviYjONjT1tZ5NQ=;
        b=l98jNEWYqh9ut5/4732ZpxyTPNeGWc9YSpQWTpRGFwAnIKzdrdRiJPHU1gHErngRab
         ukoKc4XZPa81xbBo1uS+oCX+wwNA4d0pHJ/D1/aNjpvSZ+WQ0ZSSpeSFpN2mihJqxAkF
         7dnHgE7hPj6r6tuSi32de1Ohob6Qqjro35HJ8Mur6tWuufENh8CqdVZzojEXkQO+PH7R
         D89Y5jtlJPtFDizAfP5bEkc8VoQ80g/RAMXJ3oe0uLkyHpiXOil6GiQjDGgRmJE1B6EM
         ILolwvCg9PUrMljwAZOvqNTIcy5BqDbRLIA1do/xcmGNZUZ/HVXnvrdGB+P8E56WPoHB
         e/6g==
X-Gm-Message-State: APjAAAWICbvSaWX31enqpX0l3pGiINmPayvaH42ioTB2UQQxoRE1hz8p
        AU/PsdoCnpPyXzl92ZlGM2qm6ThR2Hk=
X-Google-Smtp-Source: APXvYqyUSrfro6GO73GJRRL3JZyAbs9RnuaTC0xq5aZHpWwvuZlpI85o1QyfO4J6XZLXU9DbvJx1AA==
X-Received: by 2002:a0c:b627:: with SMTP id f39mr81010392qve.72.1564407663041;
        Mon, 29 Jul 2019 06:41:03 -0700 (PDT)
Received: from dhcp-12-212-173.gsslab.rdu.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id a23sm25762050qtp.22.2019.07.29.06.41.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 06:41:02 -0700 (PDT)
Message-ID: <ee309a53cd55517886691c36152044a630da391c.camel@redhat.com>
Subject: Re: [SUNRPC] 661ccd4df3: ltp.proc01.fail
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     bfields@fieldses.org, neilb@suse.com, linux-nfs@vger.kernel.org,
        lkp@01.org, ltp@lists.linux.it
Date:   Mon, 29 Jul 2019 09:40:57 -0400
In-Reply-To: <20190729095353.GS22106@shao2-debian>
References: <20190729095353.GS22106@shao2-debian>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2019-07-29 at 17:53 +0800, kernel test robot wrote:
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: 661ccd4df38fdcddfeb1f314ac1a1de6c947c3f9 ("[RFC PATCH]
> SUNRPC: Harden the cache 'channel' interface to only allow legitimate
> daemons")
> url: 
> https://github.com/0day-ci/linux/commits/Dave-Wysochanski/SUNRPC-Harden-the-cache-channel-interface-to-only-allow-legitimate-daemons/20190727-042349
> base: git://linux-nfs.org/~bfields/linux.git nfsd-next
> 

This patch is no good and should be NACKd.

Bruce, Neil please consider alternative patch:
[RFC PATCH] SUNRPC: Track writers of the 'channel' file to improve cache_listeners_exist


Thanks.



