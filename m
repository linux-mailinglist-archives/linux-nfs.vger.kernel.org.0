Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07BB337FBCB
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 18:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbhEMQvH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 12:51:07 -0400
Received: from p3plsmtpa08-10.prod.phx3.secureserver.net ([173.201.193.111]:38315
        "EHLO p3plsmtpa08-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230037AbhEMQvG (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 12:51:06 -0400
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 May 2021 12:51:06 EDT
Received: from [192.168.0.100] ([96.237.161.203])
        by :SMTPAUTH: with ESMTPSA
        id hEPml9G4NlLmNhEPnlRWud; Thu, 13 May 2021 09:42:24 -0700
X-CMAE-Analysis: v=2.4 cv=AN1HNu1Z c=1 sm=1 tr=0 ts=609d56f0
 a=Pd5wr8UCr3ug+LLuBLYm7w==:117 a=Pd5wr8UCr3ug+LLuBLYm7w==:17
 a=IkcTkHD0fZMA:10 a=KEpqd1ZkcCj9el2PBssA:9 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Cc:     "dan@kernelim.com" <dan@kernelim.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
References: <20210426171947.99233-1-olga.kornievskaia@gmail.com>
 <20210426171947.99233-10-olga.kornievskaia@gmail.com>
 <20210427044214.vlbmbfdh5dpq4vhl@gmail.com>
 <CAN-5tyHPHk891-NkHt=6o+OuxRB+0ZqQRKqJ=hFThE=oYM0V7Q@mail.gmail.com>
 <20210512104205.hblxgfiagbod6pis@gmail.com>
 <CAN-5tyEoaKseyjOLA+ni7rCXG7=MnDKPCC3YN68=SHm9NaC_4A@mail.gmail.com>
 <CAN-5tyHy8VR4apVCH0kFgmvceWynx5ZwngdT3_V6abDXZnmDgg@mail.gmail.com>
 <CAN-5tyG68pQwW_0+GqqF1w+CmCOUU8ncN6++jAA7i_wqibturw@mail.gmail.com>
 <20210512141623.qovczudkan5h6kjz@gmail.com>
 <c85066f64c19e751c1bdef9344a43037bb674712.camel@hammerspace.com>
 <6F49DAEE-F51F-40D5-866D-A7452126CF41@oracle.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <9eb1b276-2970-77ec-0691-1e10e6490a83@talpey.com>
Date:   Thu, 13 May 2021 12:42:22 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <6F49DAEE-F51F-40D5-866D-A7452126CF41@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfGUmjSFOLqPPn5M8xg7BePu++1TkM8IP+Oi/jlCU3Xw22MYkHPHjEgVSWpjIM/gFEWRhUtyznJYSXYvjjNfS1eCHSlrCa9gCfbV3ZRkHDtcodynURLg3
 mE0KBXGa+7c9MbuZAJ9GBoNgyFFusl+mVnoj46yf+9waMAOIAiKqsR4SD9jsGQsUqPkdK5jg0DyVZ4C/EvJtOU7KIhtvkZPZ47I39y38PKLXRKR/nwL0ypGd
 Nd38mqbDu5QHbEe3CPt8KF1nr7AyPy2XrVU8h/LS+ItnpeIKTfumhLqFruknKRC3Tf4JXuCckay+gSDvIHbMjZsSHhNRPIAPWFOR15pbdmwKPWRqufoP8q73
 HB82IIfE1UCi8Wka94QBCBgMOXnUmA==
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 5/13/2021 11:18 AM, Chuck Lever III wrote:
> I agree -- SMB multi-channel allows TCP+RDMA configurations, and its
> tough to decide how to distribute work across connections and NICs
> that have such vastly different performance characteristics.

Purely FYI on this point - SMB does not attempt to perform operations
over links which differ in transport protocol nor link speed. It
prefers RDMA over any TCP, and higher link speed over lower. When
multiple tiers exist, it relegates lower-tier connections to standby
status.

Most implementations have various tweaks to prefer or to poison
certain transports or connection associations, but the basics
are always to use homogeneous links.

Tom.
