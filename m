Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE0E54D3A97
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Mar 2022 20:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235359AbiCITsK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Mar 2022 14:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238009AbiCITsK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Mar 2022 14:48:10 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B820B83
        for <linux-nfs@vger.kernel.org>; Wed,  9 Mar 2022 11:47:08 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229JOYsj032219;
        Wed, 9 Mar 2022 19:46:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=rNm3MKoQeKjAVkh+IKfcxqAfLD+cRBs+k8Fjn8yPHiQ=;
 b=IIkzCNsUlrERjxFk6w5WaFivpzOcKI/WTy8DbFX9g5Lo3pnzEABv3NC+GQQnwJ4UJuMj
 nO6wxHJ5XOSHC+TA5EciK6vKqpAyV+LKM1Z9fB37jr2jaUDldV2iJ1J3ZtUYxkgbxLiX
 2Jtapt+Ftd0ej1Dz1sjK1Aw6zMoAlAvTybxFL75mwHORoYGSEna3/dH794iogqMXP4gH
 y1LDoEfT27vBkUP/RQ4Jbcl+YNyBVFKq7gTZIwm/uhld9Y+qhLgEd/7o/eU7Jx4vpLDb
 C0zFs30CFZKXBus5J7fEOi3Tk65G6eA1dzOcDDcRg1+J00cccXlxf/L+iOHjiqtRiTtV sQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0u6tk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 19:46:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229JREFb191285;
        Wed, 9 Mar 2022 19:46:39 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by aserp3020.oracle.com with ESMTP id 3ekyp34wvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 19:46:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y3BsGIssvi0npN8KoMNzVJFnPapO790TVxqHufDF8a4jcNQy7Vp26szvkKFKjzRgEOV0P9J/aRFkR8mxWMyPU6USbWHoI8nL8zsCZjtE9FuNz55HdNzE8SxEPhykrRQW/NHKpxTX5lJ9CVBxHYfWHOr1BeI4ywhK2VF3WZ8fAIysLDmEG4ehaP7b4gYFkE9vHCQsQhWmJZxYhWoCqzCx5bHlqVU650DSOrgIlEdyOCso4iu2bUVc0eYWbWlboD4gmJKm3gPWsuflUYUtDrdUxQR0j8ItkZFfhUzMT95swsLdRAFh+7YCTh0PM1ThGbrw+0zHd6P/W6YEJe0Mgei0+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNm3MKoQeKjAVkh+IKfcxqAfLD+cRBs+k8Fjn8yPHiQ=;
 b=LZ1RR4j23E8aYyTDHDWamK8Ad3+lKVPf14ZcM4KWmiY2GgkORXg6z0mrnuJ38LEPzOpZy7qUBDdEnEsBQ1Tw90Gx6E4tseNbOR3DXUZmYAn3x1yeyRXMZpR6uuXkvEPf6UNVz69cYIzN3GxZgqGkg11oZkip8RQSCpfiwUfHiGoLCAK2UKZys3P6bPXRNelJsHlewIB185liVo/+VgDU1vfkwKGOwPdZNdJdVm/5TpIg0fDxol/tC+Vq6pOjdUElNrZg7fsnEyed4sGTqLPPVMg1AQlxSqVNsuWkA/JObAxmE4XnNzyZsMCxr5D1Ys+ZObuh/d+gPCGSnR2gczx9xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNm3MKoQeKjAVkh+IKfcxqAfLD+cRBs+k8Fjn8yPHiQ=;
 b=dq+dPd5UtBR7lPKYvr/bloTrNvSHOifgp9EKAQ26lBT4W7+CBhx6f6dc2zWDsIE3pmiurXcAUNHxD+BMutNy5w1eVQCIsBA4ssh9LVKKSvw3w65ErugtommtGMCdh3YKgGpHqbzTz2GJJKsbs8NnGBhQfpm3yIGSVMo8LDJPzRc=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MWHPR1001MB2304.namprd10.prod.outlook.com (2603:10b6:301:2e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 19:46:36 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::29c0:c62f:cba3:510e%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 19:46:36 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     "tblume@suse.com" <tblume@suse.com>
CC:     libtirpc List <libtirpc-devel@lists.sourceforge.net>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [Libtirpc-devel] [PATCH] rpcb_clnt.c config to try
 protocolversion 2 first
Thread-Topic: [Libtirpc-devel] [PATCH] rpcb_clnt.c config to try
 protocolversion 2 first
Thread-Index: AQHYIYhKDk3jkCVie0yBKH6y3YG1OqyTK2AAgAAP9ACAAAUSgIAAMdcAgCQndoA=
Date:   Wed, 9 Mar 2022 19:46:36 +0000
Message-ID: <D449E0F8-2D93-4BFC-905B-1D12EB5EFB91@oracle.com>
References: <20220214092607.24387-1-Thomas.Blume@suse.com>
 <F1A91E0B-4544-4739-ADAD-CF9FCC9E8F66@oracle.com>
 <q7n3pnn5-6o3-524-8rn1-q7oprr139258@fhfr.pbz>
 <45A65BD8-8712-4B43-A91E-9DBA21ECE6E3@oracle.com>
 <8bf36c74a29198fad7d18434f511dca0fa5dc04c.camel@hammerspace.com>
In-Reply-To: <8bf36c74a29198fad7d18434f511dca0fa5dc04c.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e47d71d9-9bc6-44a6-6bc1-08da02058566
x-ms-traffictypediagnostic: MWHPR1001MB2304:EE_
x-microsoft-antispam-prvs: <MWHPR1001MB2304D5074C53F3365FA7F7FF930A9@MWHPR1001MB2304.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r2T1RnoIzln/9VM4GUd/ZDG5QXiDdyQ0XY2GPZzIMWpFyeNfXyGzBsM/+tyKSaBa5nKUBY6bxjbSZ3bUn+Zo55ynlLMJYwfRuE5TWuU72OZGkKuIEhX+MIVqb9efvkBmDokY8lxb6Pno7ovz+PfAGDciDZlKvmiaZyiNJw9j61EdT0p7IjPJG5r2TndyMgxFW/9JyZNtGCZdGLLZolIOb8Dj08qfYHwe8OL/euD9UnUf4RIPJUwtGU70tQZ+Pcdn8wGCB4FjMYttK+C2jHsourhe1yFA0eWZH0DcvzqjLj+eH8hNKwzzDXcfrzcGwh1IoOyEncHrgmOSEBTf2H0gZv4JPkbAF3/oRKpaHRqq1ZnJBaZ3C6Ew7nzgqXI7iA/EL/MmNmkEnN/UYlE7ZvLyrXz72TGSDbenSHd4KxspvX4+Y5D/FedpL7gjoNKP9Xp3zM8Yv6Xa1xLgTCBw1+G74qumVvyuKmX3P/7glFnYiXvo1yRzlbZBDmhdcPimdg5ZXObgJTAOhvwOdTvDFlgmg9lOvGtcZ3T6Qc9kgS1daHHHkbr5rF5NHHtGi/IC9bco93ei4SVJTgGsK+vrSgKHV28muYChuniZF7n0qQssYW6xiQ86ge51ZQHnuQXctJQtMxdn9fVW33Fviv9ch07iL5RJsSp7KBgGhxmj43ZNvhdQ8nTOvY0kykJ0FPewO/pxpP2bt8vWjHCXTvBQiPeESYx1Hv4iANKO+h9K7rh+cidUXg1kBKa6olLUlOYf5wRmNqserlri0lNlmAtyJq8AHkSdUAZ8dvXY7hAA1vKyC/7AOv5PwXgwWjPDSH9uwDlD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(66556008)(86362001)(76116006)(53546011)(2906002)(6506007)(91956017)(66476007)(66946007)(66446008)(4326008)(8676002)(64756008)(26005)(2616005)(186003)(316002)(6512007)(36756003)(6486002)(38070700005)(83380400001)(5660300002)(33656002)(8936002)(54906003)(508600001)(6916009)(71200400001)(122000001)(966005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6gvYce6V7a7jBLdMXbfb4UYSWmChQZlfTMJfJQypIzdwQ8+s0QVObC3moRK1?=
 =?us-ascii?Q?+p3YkvkW1hHT+vjGgM19PXcPB++aGSSNF2rMZi2kZmMhd2/faBbkfPpVWMJI?=
 =?us-ascii?Q?vbkQfaJFSYdvdmat0GjjmLyfopXMRvxeAHj9APH5Ibc/Xj20/YClGqPIqx6m?=
 =?us-ascii?Q?mNtN5oKp6ytpckQc2hVOujwUaRXivkpTVZ63tvPS0JpLYMZyYdoH57jK1b3g?=
 =?us-ascii?Q?mMDruX/5u+OpivWkPaVb3XPCsE+QuDweRIen03X6pFJzqgY1mb0z6bwN06gN?=
 =?us-ascii?Q?Et+oX/grnJYWNMR6QA4IAcPT7ijGy8mxoHCCdH+tYulBe+gi1mMHknDgps5z?=
 =?us-ascii?Q?4yfEAeY9rl8tPmpoSpe0PO9km6b1ljAsVZDtukh8+q8+nWHD7bF/MKO7GZWa?=
 =?us-ascii?Q?lku19/EEKG5muxvDSgmmcRWCMr1pL4Xuk7XxjYGT1EZe7X8uRTLm5EWMt7KX?=
 =?us-ascii?Q?zCYuhNgJE8edMNiF55EtqxHwDSFM31P7SxTwGkAJmqGkA2Yyrd3f9K60j+rB?=
 =?us-ascii?Q?+9hE0sWimZxuZLqIthQYg1L5MIivlVw0gl39z1rxXOebu7jkh7+m/xYlzj3g?=
 =?us-ascii?Q?VtJewePYfx9cE7iUTlRSgCNF11vdMzNdBBFetvxCG3p4FFbbCHOMIA0jdxJF?=
 =?us-ascii?Q?AfCiHDVp+KyXxWTBYyhZs1M+vxkfBdtlANWQZVVsy04S9eUpEfHUkQxzs7Mo?=
 =?us-ascii?Q?WThXZGVnJG56VFrWWz9aqyfVbn3MfEyxy+SpimrxcHRLhVzl/R7aYMdeLtub?=
 =?us-ascii?Q?/RzD/Z9+8ZFaYmkzPdyUopb+fOUOmscesB1ikqdcHLrnyQenCzFiVqEIXTGm?=
 =?us-ascii?Q?PMg/T6lVdkM1JOepTvJzMLF01tmCBNJAAYyIlkn9eubKF1Ft92J6B9ajmKlh?=
 =?us-ascii?Q?ZZnzmYB3gyCjcfBTY2vO46aEaZC4SY5judoWeHRMHVLtyr1wDTLvcOllon7J?=
 =?us-ascii?Q?C4mkhrN+4+t7H6qYmQuqZ6KxbeHGAfQqWHXwRxYkJFgzY83dFwCJgceAp3UP?=
 =?us-ascii?Q?VXQKXmvAhBMSAPwr5S8CQvtprlXDYSxmXcMnabhms4YPyaetZwlbL7PV2IsZ?=
 =?us-ascii?Q?2IEx7a+6Yw6y5vP2W6G4ZSe/oYpeUHpyuT0JYBo5TaJbXHAMgFPHY1CCjErw?=
 =?us-ascii?Q?YAUakVdaa4EZYh+X/0Rc51jV9u5ikGigSqUIal3bdq1L8whtUsoWcKaslRlW?=
 =?us-ascii?Q?7zxhwL1iPrFBcT1RJmhQch7WnTHEc1UO/PmV1TsDWYdlp87HlT/D0OZFSvSH?=
 =?us-ascii?Q?fK5nSfhpWsYIIUyoTf9X7d0E2+KsiPT9Gy4L7X3ZD2W4pAFI4p4/3HDRHfpm?=
 =?us-ascii?Q?bGZh0/dgoff3JD/RZT55Px0IZi6ah8uAWleZ04SnrjMbsJ6rHRcT3NfRtpae?=
 =?us-ascii?Q?YncbyGbmH0a/dByGY3Lo6eAStyb8G7D6mOKKlfhKZtw6SbY7Yn6Zyw/Buc5Y?=
 =?us-ascii?Q?xwWLS9Hd65HlfyQsT3IBtYom37LxhwFkKR54zRZupzCJupfCwuxVGg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07DDE5D088D95445AA4C51540B8EA4A8@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e47d71d9-9bc6-44a6-6bc1-08da02058566
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 19:46:36.1583
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jarho3QgOALnbubHY96YbiJvf0JptNjKSjWGbDukgcoZ4a5m1KJ3PQETOSRxtXJ1BaRH5ZWKxRNXXZJRs0zBPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2304
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10281 signatures=692062
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 mlxscore=0
 bulkscore=0 mlxlogscore=999 spamscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090104
X-Proofpoint-ORIG-GUID: yD5Q0XmxUOZ3EpDbQwqWfwZW4L8kWPp3
X-Proofpoint-GUID: yD5Q0XmxUOZ3EpDbQwqWfwZW4L8kWPp3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Feb 14, 2022, at 2:40 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Mon, 2022-02-14 at 16:41 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Feb 14, 2022, at 11:23 AM, Thomas Blume <tblume@suse.com> wrote:
>>>=20
>>> Hello Chuck,
>>>=20
>>> On Montag 2022-02-14 16:26, Chuck Lever III wrote:
>>>=20
>>>>> On Feb 14, 2022, at 4:26 AM, Thomas Blume via Libtirpc-devel
>>>>> <libtirpc-devel@lists.sourceforge.net> wrote:
>>>>>=20
>>>>> In some setups, it is necessary to try rpc protocol version 2
>>>>> first.
>>>>=20
>>>> Before applying this, I hope we can review previous discussions
>>>> of
>>>> this issue. I've forgotten the reason some users prefer it, or
>>>> maybe I'm just imagining we've discussed it before :-)
>>>=20
>>> We've had a discussion about 1 year ago:
>>>=20
>>> https://sourceforge.net/p/libtirpc/mailman/message/37227894/
>>>=20
>>> actually that encouraged me to send a patch, even though I
>>> initially thought
>>> is wasn't good enough for upstream.
>>=20
>> I agree that adding the sidecar file to toggle the rpcbind
>> version order is a bit rough.
>>=20
>>=20
>>>> The patch description, at the very least, has to have a lot more
>>>> detail about why this change is needed. Can it provide a URL to
>>>> threads in an email archive, for example?
>>>=20
>>> This goes back to an old SUSE bugreport following the change of rpc
>>> protocol
>>> version 2, 3, 4 to 4, 3, 2.
>>> Below an description of issue the customer was seeing:
>>>=20
>>> -->
>>> An 3rd party NFS Server is behind a F5 front end load balancer
>>> device.
>>> The F5 front end load balancer device is replacing IP addresses in
>>> packets as
>>> they head to a NFS server.
>>> It replaces IP addresses in headers but as you might expect it does
>>> not replace
>>> the IP address within the RPC data payload, i.e. within RPC GETADDR
>>> request,
>>> which places an address there for the universal address or hint.=20
>>> Without a
>>> correct hint, the GETADDR reply which comes back gives an
>>> unexpected address
>>> which happens to be unroutable from the nfs client's point of view.
>>> --<
>>>=20
>>> We agreed that this is rather an issue of the loadbalancer
>>> hardware, but we
>>> would have to address that anyway due to backward compatibility.
>>>=20
>>> So, the first question is, do we want to stay backward compatible
>>> upstream?
>>> We have to do that as distributor, but of course upstream is
>>> different.
>>=20
>> Thanks for the reminder. I suggest that it should be included
>> in the patch description if you post again so that it becomes
>> part of the libtirpc commit history.
>>=20
>>=20
>>>>> Creating the file  /etc/netconfig-try-2-first will enforce
>>>>> this.
>>>>=20
>>>> A nicer administrative API would enable you to update the whole
>>>> rpcbind version order, but that might be more work than you want
>>>> to pursue.
>>>>=20
>>>> It would be a nicer if, instead of a separate file, a line is
>>>> added to /etc/netconfig to toggle this behavior, or provide the
>>>> whole version order. E.g.
>>>>=20
>>>> # rpcbind 4 3 2
>>>>=20
>>>> # rpcbind 2 4
>>>>=20
>>>> Really, though, this isn't related to the transport definitions
>>>> in /etc/netconfig, so a separate configuration file might be
>>>> more appropriate.
>>>=20
>>> Thanks for the hints, if you deem a patch would be still desireable
>>> I will work
>>> on that.
>>=20
>> I'd like to hear other opinions. I'm not the maintainer of
>> libtirpc, I'm just someone who is very opinionated :-)
>>=20
>>=20
>=20
> Quite frankly, if you're relying on the IP address in GETADDR being
> correct, then you're going to be disappointed in a lot of
> circumstances: the common practice of using NAT and MASQUERADING in
> modern data centres (particularly when using virtualisation) typically
> break it pretty badly.
> In 1995, when RFC1833 was published, there wasn't that much widespread
> use of NAT, and there certainly wasn't heavy use of containers for
> hosting services like NFS, so it is understandable why this happened,
> but today we should know better.

Hi Thomas-

Would it make sense to change the behavior of the libtirpc GETADDR
implementation to ignore the embedded IP address and extract only
the port number from the returned universal address? Then
administrative intervention would be unnecessary.


> So which applications are still relying on the address from GETADDR in
> order to work correctly? As far as I know, 'mount' does not. I seem to
> remember that 'showmount' is borken, and needs to be fixed. Others?


--
Chuck Lever



