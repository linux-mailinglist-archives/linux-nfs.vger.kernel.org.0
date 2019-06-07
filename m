Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE28038CF5
	for <lists+linux-nfs@lfdr.de>; Fri,  7 Jun 2019 16:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfFGO10 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 7 Jun 2019 10:27:26 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37708 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbfFGO1Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 7 Jun 2019 10:27:25 -0400
Received: by mail-qt1-f196.google.com with SMTP id y57so2463895qtk.4
        for <linux-nfs@vger.kernel.org>; Fri, 07 Jun 2019 07:27:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tpbp2TmAO7Oppvr/Cdw67uDnOqiqK/Suj6crpUYdvMU=;
        b=p4YvZ5vsqcwHGRs2nI0sT7LkrILGNm2xEoEsYcHyjHf7MIu6l6b9Q56mmtQ03Tl3MU
         xCf+6XcamPI38w6C5NsEUSFBXHB2woOQCB5CntY+n4HRAeIxVJOrIodFCInZyI8KWs78
         U+ZDed//Qy4tX7AKCJwZ97QEyoibJggLWvteNJAH4yqvHQteO95FUSvy/uGnsxem2A10
         MuBHWOsB2oTGfuXEyzPAfDPxyuugOFTh+Prg12LJe3J8+fTkRBpHuzcqkaBQvtLQ8dpU
         d8Xb4CP247Bo8evjMwGk6s+djY67xFduRyBRjzqOqUc3sNHKcpPqO98yYvFIghn/Ve4O
         c98A==
X-Gm-Message-State: APjAAAWn0NMR0b/Vg39IHMAl4gvvLBhJbIBPcN8EZfjlTKT3pvVaEhnN
        jLWvu1iM7EM2yU/gRjXb0ru2dQ==
X-Google-Smtp-Source: APXvYqz6pQE/B++soQFmjd3kLp7wONHTsiCFTWp9E89/Jkml2eFwiSMajeq2/tGsO/ILWNk2rIStpw==
X-Received: by 2002:a0c:a066:: with SMTP id b93mr43103121qva.140.1559917645035;
        Fri, 07 Jun 2019 07:27:25 -0700 (PDT)
Received: from dhcp-12-212-173.gsslab.rdu.redhat.com (nat-pool-rdu-t.redhat.com. [66.187.233.202])
        by smtp.gmail.com with ESMTPSA id n124sm1146886qkf.31.2019.06.07.07.27.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 07:27:24 -0700 (PDT)
Message-ID: <8e5ab8dce77901ea7f34e5424a7d1c75ac7689ae.camel@redhat.com>
Subject: Re: [PATCH 3/3] SUNRPC: Count ops completing with tk_status < 0
From:   Dave Wysochanski <dwysocha@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Fri, 07 Jun 2019 10:27:22 -0400
In-Reply-To: <20190604144535.GA19422@fieldses.org>
References: <20190523201351.12232-1-dwysocha@redhat.com>
         <20190523201351.12232-3-dwysocha@redhat.com>
         <20190530213857.GA24802@fieldses.org>
         <9B9F0C9B-C493-44F5-ABD1-6B2B4BAA2F08@oracle.com>
         <20190530223314.GA25368@fieldses.org>
         <CD3B0503-ABA0-4670-9A76-0B9DF0AE5B5C@oracle.com>
         <f7976bde9979e8b763c0009b523331ab5ce6b6ed.camel@redhat.com>
         <5CE8A68E-F5C2-4321-8F57-451F5E5AF789@oracle.com>
         <20190604144535.GA19422@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-2.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2019-06-04 at 10:45 -0400, Bruce Fields wrote:
> On Mon, Jun 03, 2019 at 02:56:29PM -0400, Chuck Lever wrote:
> > > On Jun 3, 2019, at 2:53 PM, Dave Wysochanski <dwysocha@redhat.com
> > > > wrote:
> > > On Fri, 2019-05-31 at 09:25 -0400, Chuck Lever wrote:
> > > > > On May 30, 2019, at 6:33 PM, Bruce Fields <
> > > > > bfields@fieldses.org>
> > > > > wrote:
> > > > > On Thu, May 30, 2019 at 06:19:54PM -0400, Chuck Lever wrote:
> > > > > > We now have trace points that can do that too.
> > > > > 
> > > > > You mean, that can report every error (and its value)?
> > > > 
> > > > Yes, the nfs_xdr_status trace point reports the error by value
> > > > and
> > > > symbolic name.
> > > 
> > > The tracepoint is very useful I agree.  I don't think it will
> > > show:
> > > a) the mount
> > > b) the opcode
> > > 
> > > Or am I mistaken and there's a way to get those with a filter or
> > > another tracepoint?
> > 
> > The opcode can be exposed by another trace point, but the link
> > between
> > the two trace points is tenuous and could be improved.
> > 
> > I don't believe any of the NFS trace points expose the mount. My
> > testing
> > is largely on a single mount so my imagination stopped there.
> 
> Dumb question: is it possible to add more fields to tracepoints
> without
> breaking some kind of backwards compatibility?
> 
> I wonder if adding, say, an xid and an xprt pointer to tracepoints
> when
> available would help with this kind of thing.
> 
> In any case, I think Dave's stats will still be handy if only because
> they're on all the time.
> 
> --b.

Trond or Anna, will you take this series for mountstats or are you
opposed to it?

I think it is useful in conjuction with the tracepoints because it is
always on and easy to know which mount is involved (we often start with
a customer saying mount XYZ has some issue or is hanging).  If you see
problems or want other testing please let me know.

Thanks!

