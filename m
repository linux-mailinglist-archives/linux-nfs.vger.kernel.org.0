Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAC97050EB
	for <lists+linux-nfs@lfdr.de>; Tue, 16 May 2023 16:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233988AbjEPOgl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 16 May 2023 10:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbjEPOgg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 16 May 2023 10:36:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444EF7A92
        for <linux-nfs@vger.kernel.org>; Tue, 16 May 2023 07:36:33 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-8-yAXuvbLIMxym3I4uiJP6oA-1; Tue, 16 May 2023 15:36:31 +0100
X-MC-Unique: yAXuvbLIMxym3I4uiJP6oA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 16 May
 2023 15:36:30 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 16 May 2023 15:36:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Chuck Lever III' <chuck.lever@oracle.com>
CC:     Azeem Shaikh <azeemshaikh38@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] NFSD: Remove open coding of string copy
Thread-Topic: [PATCH v3] NFSD: Remove open coding of string copy
Thread-Index: AQHZhtarLR7mMXSOG0mD9inDFwvZGq9cpMAQgAA9NACAABfNkA==
Date:   Tue, 16 May 2023 14:36:29 +0000
Message-ID: <6af8294f4a744cfc8bad3de754047b0a@AcuMS.aculab.com>
References: <20230515024044.2677124-1-azeemshaikh38@gmail.com>
 <d48a166d1cbc477f9cf063e91f7b3005@AcuMS.aculab.com>
 <63008A50-48CC-4915-88D6-71EA1B289322@oracle.com>
In-Reply-To: <63008A50-48CC-4915-88D6-71EA1B289322@oracle.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever III
> Sent: 16 May 2023 15:11
> 
> > On May 16, 2023, at 5:33 AM, David Laight <David.Laight@ACULAB.COM> wrote:
> >
> > From: Azeem Shaikh
> >> Sent: 15 May 2023 03:41
> >>
> >> Instead of open coding a __dynamic_array(), use the __string() and
> >> __assign_str() helper macros that exist for this kind of use case.
> >
> > Is this actually a dynamic array, or just a char[8] ?
> > On 64 bit copying a short fixed-length string is far better
> > than any kind of dynamic sized allocation.
> 
> I'd prefer to use a string helper, since the netid is a string,
> and this documents the data type better and it is not subject
> to sudden breakage if someone creates a standard netid longer
> than 8 characters.
> 
> The nfsd_cb_setup tracepoint is not in a performance-sensitive
> path.
> 
> In addition, trace consumers should be able to count on the
> string helpers to perform memory copies without overrunning
> either the source or destination buffers... one less source
> of error.

That is an entirely different justification :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

