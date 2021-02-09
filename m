Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D44C315A4F
	for <lists+linux-nfs@lfdr.de>; Wed, 10 Feb 2021 00:52:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234138AbhBIXwP (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 Feb 2021 18:52:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:41878 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234375AbhBIW4v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 Feb 2021 17:56:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119Mig4A081280;
        Tue, 9 Feb 2021 22:55:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=rSNrD1rL2cC1jEWVUuDBv5x5nqm+lFGxDGyL6/2cWq0=;
 b=fhTI5BHTazi5lrPRsSzBzvigZhx562BHkDIRvgGRTQ/6enzu0exBT20NGqdXP/Spu/wK
 YvuGV5Iy/2owHhXloykpClAI6MktBSl3ZtfZrRniJQGpt6AJe4xbEyFjfDO9jyit7bES
 BVkfK6c+t9WqxyKdCYQIXTAs5T7b7MsK2u1mPzojjNgWF5nOGYIhP287H39Hn+inmeZw
 41A6xmoDB/3BTkAy6sCsWN79lHItAXYj9uGMJvQulxq2diLB8AUWlmTXNBZCrWdZYSHs
 /q/AIoZlhP6RV28FUp9rOX2ISI1u5/SOeBAndNcbYW8TfJhUuRUOYYxkjCXzs7cyYms1 9g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 36hjhqsbga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 22:55:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 119Mj1RQ159637;
        Tue, 9 Feb 2021 22:55:37 GMT
Received: from nam04-bn3-obe.outbound.protection.outlook.com (mail-bn3nam04lp2051.outbound.protection.outlook.com [104.47.46.51])
        by userp3030.oracle.com with ESMTP id 36j51wsrrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 09 Feb 2021 22:55:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dinnM1K2nz4tq/7lO4b7ij3vLYMy0rII+Jxte4HL65zqzx1ER1l0jchR4J8aM6AuhwCODIDWkFKrbmD9lkTDQ1RIvJ8EJtOoRpyTE8ZDH4fjmsSIced5K84fjzRaA2mUBWsOOHMJ2Rzq2zHbicGCpmFiz9RLw3fz/oefITHgzE5WdRDjC179c6DtqTdrdwXuIAKRW8RkoJBuEPbtkaojalvbaaNnRzc78hqVVplu8ZtWCgC1nSVSozR1cT6+uk3Tl3aSwuzVvrnFPLaZN5eXi8DfQtcjx7CM+W8zuJ8JZPRTbL/snkqyCj6yUVvx1JYPK2/6Y8AwE+wlMQ2emU2Vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSNrD1rL2cC1jEWVUuDBv5x5nqm+lFGxDGyL6/2cWq0=;
 b=lG0EsBbJt6dvADSiHTSIJE0/EI/J7EJQEzpfDo1ING6fv+JGPt+X/ocBEhuLK35qQ/T/D9sa5tQBcyYuo6+PvCUr2liLw1O9E89WyyVL8GJezkgL+zrt/8TEcjgLG4raFTAzD1M7uHds9Fqk5VLonb/UM7T+Z2ZAobdHx8gM9Vlk94ZzuKnLYCfFIDAr/RfOqXlbIsWuHAG9MXAtRU6oMqEjEMSBccmve4NYbqvTZomtxJvZY1Dl81miJLhzQCixSnH1m9t0C38KkDNfXJozdFR0DEuZrImY8cfL28cBho3YbDq4ZJ95OmrxMj4AwgOfr888EpIYTdYb4F4tkp+zxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSNrD1rL2cC1jEWVUuDBv5x5nqm+lFGxDGyL6/2cWq0=;
 b=OixpYbbEZ8aore/7Dw2dL12OhTvFaazcdoTtDYQX71HAuq6P6wbBVAsm4JSRFKoZEaMzicR+a3ZvbAB0GSSfWXgVvDSC3/3XaSXCeHS1xOq3VLMnXRbfc/OjrHCxlGJ/3/vuRkNxbBbu1RhfY/Ok7YW49ChmHwSO94xempy0uOI=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4496.namprd10.prod.outlook.com (2603:10b6:a03:2d5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Tue, 9 Feb
 2021 22:55:35 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3846.026; Tue, 9 Feb 2021
 22:55:35 +0000
From:   Chuck Lever <chuck.lever@oracle.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     "mgorman@suse.de" <mgorman@suse.de>,
        "brouer@redhat.com" <brouer@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: alloc_pages_bulk()
Thread-Topic: alloc_pages_bulk()
Thread-Index: AQHW/zatrIoqdw2XdE2fQ3DVDGYOMQ==
Date:   Tue, 9 Feb 2021 22:55:35 +0000
Message-ID: <D683D2BD-FF98-4DD2-A6D2-BA10BB132011@oracle.com>
References: <2A0C36E7-8CB0-486F-A8DB-463CA28C5C5D@oracle.com>
 <EEB0B974-6E63-41A0-9C01-F0DEA39FC4BF@oracle.com>
 <20210209220127.GB308988@casper.infradead.org>
In-Reply-To: <20210209220127.GB308988@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c000a32-c1dd-4353-9e0e-08d8cd4dcfe4
x-ms-traffictypediagnostic: SJ0PR10MB4496:
x-microsoft-antispam-prvs: <SJ0PR10MB44962F15F7FD923CEBB0929E938E9@SJ0PR10MB4496.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OuH3d+daCqmZQmXrAF/EWtBdfbqZnmKiWKFpgoBxuJzEiqCSHP6j5PB9oL6+GkF199T+oZrAgQcIm38s/OI4iBrb9MeeDnjKgGOdfGezPe9HA3JkrDINObLbV/w/bC3i6TQYmQjncHZnanUQ8MDrtoIyu8DpXMIxCnI9mVoq8BOu69m4oc3Yqm5yYGnuoOaghi1lp0q+9XM4WPs2oxnXoqniPfyaDvJTNHneLyrTe8VoyoLKl6hv4sfxvyiOY9w5d3CUjdqQ4fye/dqA06VkLddTE7coJex8clQvk0YRFxVTjU3IyFig3H36SofxMOD7bagUGrIWnQiHR/AeMQFWBLbrFuB2o/sfJhpVjGTB9DIl4tZUQARmYt8V2n+eump49Vd4SwveUJM9lWPXb2/zT5IrbthmcRVuGEJkCRevMAnLv7ZtDQif+6P08VNIG9XJMb6+pqlYxsMxWJ5QGg5mo7sciLdD40ikdPlwt4p/sn4r7B2JnDF2qfjS9f4n0zmUVLwifFZouY3jD2FoU7307vl1IpXWRsKzgIObvrYUCa5TZvFQPzCSg4crbSX1/nTCQQvV5iIY1OR8x2dBN3q+qg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(396003)(136003)(6512007)(478600001)(86362001)(26005)(7116003)(2906002)(316002)(54906003)(53546011)(66946007)(36756003)(76116006)(33656002)(4326008)(6506007)(66556008)(6486002)(64756008)(44832011)(2616005)(5660300002)(186003)(6916009)(66446008)(8936002)(83380400001)(91956017)(8676002)(66476007)(71200400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Wf7DUrqjQ1edyndZ+thCxJyYsLvhfpXpvrzpS4YEhoxetnN12p6C7SIltJ3g?=
 =?us-ascii?Q?4YpsA3MszXQM0GRqRC1r0YMCHICVwJREy58PdtK5OEI444pkUx+0HHIQ2TO7?=
 =?us-ascii?Q?ukhO57LdpTgl9Xmcb7Hh+r1hFoRM900+nbZdjTJnKP/v//75x0T4zUYwsXh4?=
 =?us-ascii?Q?xzjLv3n3NRz2NpTHXBTr3pAURE68UqOsnl5tMJ8YMgnusOJ0vbbM9T0r3LCx?=
 =?us-ascii?Q?QijR2XlZOkDXOVGyeOg2ay1IT7TNdofJrJy4v8tt6+YAmBTia6+ASYqCWI7/?=
 =?us-ascii?Q?DonM16lhK0K4c9ZcSWwGX19dpIsg/r5NLtPxuCkz51OsiihBwuli/Hl05RuE?=
 =?us-ascii?Q?bJO75qgOGp4FYSoF05VoPn6TlZ3ciBDRM/4TjYtpMrp6YRRBshCpJPhn5qdU?=
 =?us-ascii?Q?cDhQFTpciS+hMP1G86khdm6eWoml+mxOKoSWdfMHHft09NZQt9pmJMVFSkBw?=
 =?us-ascii?Q?43LDpWHEZbT/5a+wTVLBQ1gXFZwlRQqZeOuT5tK6hS4YitgH1LiTn0HnEdIZ?=
 =?us-ascii?Q?bAQjt1wVh6G9PJiCDya3gD7witMB2m3Mzcd0yHnUfSltRsaktdys+hTKFSAW?=
 =?us-ascii?Q?MJumSo5N6/4juu/OVEmCvvU4vh3eezyrQKosjc11CQ59bhPTFyNJsFABoxIe?=
 =?us-ascii?Q?rFH9BJTynpyyGw4RSWRtyu5RuAMC8WLW7DfRQSPtBORP7B8BuKYF17R0qKYr?=
 =?us-ascii?Q?CSuVe4HRGuA8VFIFXaFKixl+xfejRPzSjcOCIiaKRLpYxqDaCK3uPJ2S5YpZ?=
 =?us-ascii?Q?XTh3L56lMqt/ELqCMOyyHyybcD3xQVjbAtiH01I8/QLgT/bfEVTMakxcMNnq?=
 =?us-ascii?Q?uAhwQVWENp4fuJ1UahTLSYaG2kTMtx3VsDedq7hcLdXq1wd/jSuyVXGLmBGB?=
 =?us-ascii?Q?5CAe866pgiRNBOxYabxvHIzzNoVSYpcP8fKP+et+RUqsAOZCyZGGwp++9Mg8?=
 =?us-ascii?Q?9NxaPqjkuIRBM6jtq2n3izu1McsEGlqDUtUKaGC0i6uMg1D+P1AFIOHKQql3?=
 =?us-ascii?Q?YiybKC6Xkzm++tbPeT5CiWchMHLVlrYPuGMrQHiCrQzikBgcnR+tEA6WRMPt?=
 =?us-ascii?Q?vCH0+3BEgLyAsiOfDdduBfzn6Zq6ZPK7kUcyFu0bfDyhvdBk1P8pgfrmQnaS?=
 =?us-ascii?Q?qMx/5/nqiqJ02Z3Kizfq+qCQ7Nfxfnue/qQXa8rcJvQ6+oryRXgmmflqCgw7?=
 =?us-ascii?Q?QzP+drpMXz1o12mkDK458OliqAdSagVG9gwN37cAFijSa5ZE9a4FWSr7nJJl?=
 =?us-ascii?Q?6uz4vClD3IM6OXVIcfsgdXjPQ5Uy3468np6fIHCPTILSRVWf3YjFThd2mqP6?=
 =?us-ascii?Q?jFj6hWkOxxRFFmY7ihOcFK6e?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2BCCE04A72B89C4D8DE83CF4CB4F83A0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c000a32-c1dd-4353-9e0e-08d8cd4dcfe4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Feb 2021 22:55:35.6021
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiDLy3NWSHQzUg4VKRLeQU5HGbfUw7+tVPWjutDEJwLtzc2JfdF0/gZBzqksswztoXPPyeKeXVFjW0aJqpgFYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4496
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=983 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090118
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9890 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2102090118
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 9, 2021, at 5:01 PM, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> On Mon, Feb 08, 2021 at 05:50:51PM +0000, Chuck Lever wrote:
>>> We've been discussing how NFSD can more efficiently refill its
>>> receive buffers (currently alloc_page() in a loop; see
>>> net/sunrpc/svc_xprt.c::svc_alloc_arg()).
>=20
> I'm not familiar with the sunrpc architecture, but this feels like you're
> trying to optimise something that shouldn't exist.  Ideally a write
> would ask the page cache for the pages that correspond to the portion
> of the file which is being written to.  I appreciate that doesn't work
> well for, eg, NFS-over-TCP, but for NFS over any kind of RDMA, that
> should be possible, right?

(Note there is room for improvement for both transport types).

Since you asked ;-) there are four broad categories of NFSD I/O.

1.  Receive an ingress RPC message (typically a Call)

2.  Read from a file

3.  Write to a file

4.  Send an egress RPC message (typically a Reply)

A server RPC transaction is some combination of these, usually
1, 2, and 4; or 1, 3, and 4.

To do 1, the server allocates a set of order-0 pages to form a
receive buffer and a set of order-0 pages to form a send buffer.
We want to handle this with bulk allocation. The Call is then
received into the receive buffer pages.

The receive buffer pages typically stay with the nfsd thread for
its lifetime, but the send buffer pages do not. We want to use a
buffer page size that matches the page cache size (see below) and
also a size small enough that makes allocation very unlikely to
fail. The largest transactions (NFS READ and WRITE) use up to 1MB
worth of pages.

Category two can be done by copying the file's pages into the send
buffer pages, or it can be done via a splice. When a splice is
done, the send buffer pages allocated above are released first
before being replaced in the buffer with the file's pages.

3 is currently done only by copying receive buffer pages to file
pages. Pages are neither allocated or released by this category
of I/O. There are various reasons for this, but it's an area that
could stand some attention.

Sending (category 4) passes the send buffer pages to kernel_sendpage(),
which bumps the page count on them. When sendpage() returns, the
server does a put_page() on all of those pages, then goes back to
category 1 to replace the consumed send buffer pages. When the
network layer is finished with the pages, it releases them.

There are two reasons I can see for this:

1. A network send isn't complete until the server gets an ACK from
the client. This can take a while. I'm not aware of a TCP-provided
mechanism to indicate when the ACK has arrived, so the server can't
re-use them. (RDMA has an affirmative send completion event that
we can use to reduce send buffer churn).

2. If a splice was done, the send buffer pages that are also file
pages can't be re-used for the next RPC send buffer because
overwriting their content would corrupt the file. Thus they must
also be released and replaced.


--
Chuck Lever



