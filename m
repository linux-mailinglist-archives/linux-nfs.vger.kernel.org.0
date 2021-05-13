Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D833D37FA77
	for <lists+linux-nfs@lfdr.de>; Thu, 13 May 2021 17:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhEMPTt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 May 2021 11:19:49 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:34702 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234783AbhEMPTn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 May 2021 11:19:43 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14DF3X5g014940;
        Thu, 13 May 2021 15:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BHy6asrLOliUL9rPT4ZifGyZqICOyDfwv+msv7scxQg=;
 b=hOXCNRcT/0kSxsrq0sr26MllFETUv8y3vNHLA68VXsvdCj8HV7X5pzuae+d8p2HdYdnF
 zbmLklxyES08M51i/myMI1VEg1AnsaRPcb0AprAspGhd0s7RFtZ/DmzHzYawiBMRPmBR
 9x2tCDZWh8mHOLEFgGXwVzfZDFSZ5cLnu3MmSHPA4Y2TxlaFfzGjERRllzf24Yll5L5r
 IrXuBeVR4onapFYKe6fjoS4NGy3/0ILC9qYh3rHlEF64z8r7AiIq6ML+ww1AyPuu8sId
 T4jqSSnZLCqZa7rWvlDqxx34pkqBqgko+rPgcSVcKbjSDrl/edlBBFZdjXLRciPx+LFi Cg== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 38gpqmgan3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 15:18:29 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 14DFISiY155800;
        Thu, 13 May 2021 15:18:28 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2104.outbound.protection.outlook.com [104.47.55.104])
        by userp3020.oracle.com with ESMTP id 38gppga06r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 May 2021 15:18:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l76gmi/ZSCWJtsegT6qAajIZaCKxMI0KLdYBeqBATXrNpe3+BfqXYDWaP5LRvuH+8/HJFVrSOjH8BdxItc/NLoa3ASInW0h5aUIBSujscoE6vBFzxobvs8y8FI3IIA/5ccdUO1kMh+7u8fXI/ppvu/gjJAXKCqSFpKewFPHiZgDWRm6zEzBSaEo3NZ62BmItRUneUC3yiaQiUcQ9A3EQM4y3TYkUX/9aBE16eeNh8Gdwy4FIDRPEV4v7kmTu6IhnSGWuMxI+gCEMonktfV7qVW4yHPkOFVVlnTzjBWQDt306ncTVkEVld3Vjez8kX7Vcm013mT07gdzJDGgokozAeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHy6asrLOliUL9rPT4ZifGyZqICOyDfwv+msv7scxQg=;
 b=VrTfok+M0tnchuughabS9iN3/vDDWWx6UgdQNi6UKKCITUff+x40+UPTKT5Co0dQO9LNGvHG2HbyBY5YeDSVTmNeUYprLcFLFz3hwYxiQ2OFUtaDBPbg259B3RR9pLth0JZVaW2ioHJginy3jNj9GzQmGRXTf9R/SlAbF16d0moX9hhMDtc1tERaAJsXzeGy3IDbYIUKlQdGBGNL0eGgAMbwwRx5sVlxvnKD+ptjiXdcgXmKLTSEDDP23/7eWuzh5LW2yC+yNDnTF1pr1a1840nNov8FOhi5O+ddpAl7Ez1PJwwHE2kdJ21dhun1hZ1bigGwQlFcnhovymwW5IZTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BHy6asrLOliUL9rPT4ZifGyZqICOyDfwv+msv7scxQg=;
 b=sGHmxkNlXUrAyMzHYmloneF2CGPBGiQpzYpzO304bGUkw/DdUx5qi5kM0unoQCw8oaoU8Mx1oN7+vuOgpyu8ADRFe6PZIZQNYAJYwH5vT1lTm8dDx55CTioTSM2Q+DIRTMvd2lsIz6ZmF2T6QL26NxfA4oxNxDBYZ5fABXAaHsY=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB3333.namprd10.prod.outlook.com (2603:10b6:a03:14e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.29; Thu, 13 May
 2021 15:18:25 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::2d8b:b7de:e1ce:dcb1%3]) with mapi id 15.20.4129.025; Thu, 13 May 2021
 15:18:25 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>
CC:     "dan@kernelim.com" <dan@kernelim.com>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Anna Schumaker <anna.schumaker@netapp.com>
Subject: Re: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
Thread-Topic: [PATCH v3 09/13] sunrpc: add a symlink from rpc-client directory
 to the xprt_switch
Thread-Index: AQHXOsByJn5NdWxQc0uAQ4oJRbJ9uarHyeIAgAB96YCAF3magIAAMgLGgAAJ+dyAAaIpgIAAAWQA
Date:   Thu, 13 May 2021 15:18:25 +0000
Message-ID: <6F49DAEE-F51F-40D5-866D-A7452126CF41@oracle.com>
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
In-Reply-To: <c85066f64c19e751c1bdef9344a43037bb674712.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ca691235-3bcc-4ff0-02ed-08d916225ad1
x-ms-traffictypediagnostic: BYAPR10MB3333:
x-microsoft-antispam-prvs: <BYAPR10MB33334EFE3FFDCC91F2D17C3293519@BYAPR10MB3333.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6van6/JWm5m5k4ZrGXHRcKoeIZbSIjq9vqD0v2lh2PC8Ml9RdIQDAQMSVK/m3hvqzBMstRfJk6BrqnNvchvqR8sdMt29xn48JGk0Wk8rZ/8YGZwAiwvvbdOd17ISDzp0Yi0SCORYVJJ7vz3UXMdnYRPytJ3bq0r5IESfoeV6kq99KHmBMtH7X8R2kGYS6YftiVqoDI7tgru8nMx6ykSXSpUmfoRj+SInzXcCcshGyNXJ4+0nUUQwMd8kpGzQQ4Tf5EL5o4EsrsEBpmErJ5qLIfyQQZAQgcdO1Ikm2iJ5tM+szQLp47OswRaBDczjom2Iv1xK9tX3civuabal4JCGWebUVwH5elnhlhKYzJwdJba1s+V77Zt+qSfAjhUTSR1AWeDe/q30Ck7FeeL8N8qGzLquSdHwURGmy9sm9j5fhNFu0DAG3jBSLPwMS/JZJAeNOM5yXKo/8me97GowejC6ZgfHAa57YYhH5BFGt2mY1CPQLutnTMCc3e9O/LNmMRmmS/KYSXSr9aotpi130HBgvj8xtVsQHZX56RdJCjm7xw9LqRxM5CwHnT/mDzBUG9JwTIvsFA74hTkRupkAe3BJmdIGWHeeDYLm77jbeidOtthpF/Wib5gQzRHtnvYJLQuveQY2h8oG11i/WlIUfK8nLtHkwHR+8qapLii294mDh2U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(122000001)(6486002)(38100700002)(6512007)(8936002)(54906003)(66446008)(478600001)(8676002)(6506007)(26005)(86362001)(71200400001)(316002)(36756003)(83380400001)(91956017)(4326008)(5660300002)(76116006)(66556008)(64756008)(66946007)(33656002)(2906002)(66476007)(53546011)(186003)(2616005)(6916009)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?du5XcgkbY6W0Sx8ProN74oHBLHMcKGxTwIH3NvzipwBnysGq4OPfor9/okOZ?=
 =?us-ascii?Q?MM8xcmbJt8zF5fa9bREXz+Hku9Vz8BiIbgrcGO5payRc90wQU8koDcSE75Nb?=
 =?us-ascii?Q?Y+TUUxLHwWucywjEqC2bglYQCl9BXirdvhw9bfQJPkF1kHJUFjtNRdZ/zkju?=
 =?us-ascii?Q?r9hiH/jLJKbpTDI8hA53ErlVt+VbogaSK+Hvr7ZBnWRQsRAovdshsczcXlb0?=
 =?us-ascii?Q?cGW+uITPsyzVszxNl/HyzM9MNV2zc2ed9w8RmIIXLV0zMoMLSekfrDPS2KYt?=
 =?us-ascii?Q?zzKrthfBY452ZhKUb3BVEoaOBILQpRGR+2VCsrr0r3A58IveaVh9MUIZsRHk?=
 =?us-ascii?Q?6WESpOoTVCyxRg5mFwQU6zFXq2wA0uB9/crS0Q5CN0hV1yT/PivnjgCN6sTu?=
 =?us-ascii?Q?oawMNCMj0o/lTI66kHD7Q6Ilqhs2eEfs5huqI0/U3yw7UKOjE57/OVPP4tXn?=
 =?us-ascii?Q?jUzEi+6V81uyihjy63TxeVYoLRDvLSznNhS3YeiPlHWaleXhcKJse/7iZ3VN?=
 =?us-ascii?Q?4bFy0WOWvHSgKTBfiNV0iNVHGnKKvdeG4EzLO2Nf08uC8geDkragPRNrzI5q?=
 =?us-ascii?Q?G5zJ7eIWYMIEPsaUmOuOqHjtck/C4xu3egB2g8R351ASRfXoalUXKQu0bGHo?=
 =?us-ascii?Q?u3WT76OsvYu9R3VYfh4VXUjyQlCVNfU4IImdMGvLEe73hEMD4shWTnvGRCfY?=
 =?us-ascii?Q?1wVf8C8frCZvRzsWnJ2E/Nj9li/qdTFadGVuYVwJvE1CE/tTcXI0M8fDOAsJ?=
 =?us-ascii?Q?AQ4v+xtCYwnhCLUb4z328oXzZUZfNXKTtQg+nyGAq2oR9tIsn6j2XDUMy6Kr?=
 =?us-ascii?Q?+nYpzs8sHqHQaqLgUcsKuHlbfKKCo+E4Gw82y5iZwhljZpzqhrJ45OXjZXwX?=
 =?us-ascii?Q?CpTxF+0qeNUTVHtiefr6Tt0WwSkRT0ZGimNdjSfhUopmIgs7rh6TrnaRiElF?=
 =?us-ascii?Q?6J6AACtUkeAv5MKKlV/HRRcWycvZuvgVnFs8v9XNA4otMTXSLjxZcw8C4dJv?=
 =?us-ascii?Q?lpd625JuOlSucGkEtgCqxbCq2OoNovcC/eRQ8eyj88MIwjQELQWEd1K1HwVU?=
 =?us-ascii?Q?lvVy4dBv75dGOU9WY8a6bFIwANErae5DSllCMEOSvqGaT32s7nHDgVxhkt27?=
 =?us-ascii?Q?G47c7TH3UNhm69+RQUegywOMdyZpvrrm0fK8XqCdfWmlmEzw1UneXi+6uHpI?=
 =?us-ascii?Q?3Vl8CQ6xmiMJQVDgmhR3hCFPx4T7eUyt6LlY2H2y37aNsEpIRPqiGOBs0T2w?=
 =?us-ascii?Q?5sT2OYeRSRSI9ICSOdZHRhe/drf72H5Vv4rbFhoT2Y98no+VNXzz+CGmnveu?=
 =?us-ascii?Q?HRy8TIwEaeFYnUCeS+9WsO/E?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4089EB653093C64AAE65F31A6D6BB840@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca691235-3bcc-4ff0-02ed-08d916225ad1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2021 15:18:25.7484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FcbO/1X50sNfncH4+WGtTEyNJlTEME8Wv7UVjkcAPMbfJhAFHUd4y0c+ZPGEQRwcUjGTjIbDft+MxE1meqR0PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3333
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9982 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105130110
X-Proofpoint-GUID: xZ-XygsctKAzfX9OuZn7xUmgzuWr5l8W
X-Proofpoint-ORIG-GUID: xZ-XygsctKAzfX9OuZn7xUmgzuWr5l8W
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 13, 2021, at 11:13 AM, Trond Myklebust <trondmy@hammerspace.com> w=
rote:
>=20
> On Wed, 2021-05-12 at 17:16 +0300, Dan Aloni wrote:
>> On Wed, May 12, 2021 at 09:49:01AM -0400, Olga Kornievskaia wrote:
>>> On Wed, May 12, 2021 at 9:40 AM Olga Kornievskaia <
>>> olga.kornievskaia@gmail.com> wrote:
>>>=20
>>>> On Wed, May 12, 2021 at 9:37 AM Olga Kornievskaia
>>>> <olga.kornievskaia@gmail.com> wrote:
>>>>> On Wed, May 12, 2021 at 6:42 AM Dan Aloni <dan@kernelim.com>
>>>>> wrote:
>>>>>> On Tue, Apr 27, 2021 at 08:12:53AM -0400, Olga Kornievskaia
>>>>>> wrote:
>>>>>>> On Tue, Apr 27, 2021 at 12:42 AM Dan Aloni <
>>>>>>> dan@kernelim.com> wrote:
>>>>>>>> On Mon, Apr 26, 2021 at 01:19:43PM -0400, Olga
>>>>>>>> Kornievskaia wrote:
>>>>>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>>>>>=20
>>>>>>>>> An rpc client uses a transport switch and one ore more
>>>>>>>>> transports
>>>>>>>>> associated with that switch. Since transports are
>>>>>>>>> shared among
>>>>>>>>> rpc clients, create a symlink into the xprt_switch
>>>>>>>>> directory
>>>>>>>>> instead of duplicating entries under each rpc client.
>>>>>>>>>=20
>>>>>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>>>>>>>=20
>>>>>>>>> ..
>>>>>>>>> @@ -188,6 +204,11 @@ void
>>>>>>>>> rpc_sysfs_client_destroy(struct
>>>> rpc_clnt *clnt)
>>>>>>>>>       struct rpc_sysfs_client *rpc_client =3D clnt-
>>>>>>>>>> cl_sysfs;
>>>>>>>>>=20
>>>>>>>>>       if (rpc_client) {
>>>>>>>>> +             char name[23];
>>>>>>>>> +
>>>>>>>>> +             snprintf(name, sizeof(name), "switch-%d",
>>>>>>>>> +                      rpc_client->xprt_switch-
>>>>>>>>>> xps_id);
>>>>>>>>> +             sysfs_remove_link(&rpc_client->kobject,
>>>>>>>>> name);
>>>>>>>>=20
>>>>>>>> Hi Olga,
>>>>>>>>=20
>>>>>>>> If a client can use a single switch, shouldn't the name
>>>>>>>> of the
>>>> symlink
>>>>>>>> be just "switch"? This is to be consistent with other
>>>>>>>> symlinks in
>>>>>>>> `sysfs` such as the ones in block layer, for example in
>>>>>>>> my
>>>>>>>> `/sys/block/sda`:
>>>>>>>>=20
>>>>>>>>     bdi ->
>>>>>>>> ../../../../../../../../../../../virtual/bdi/8:0
>>>>>>>>     device -> ../../../5:0:0:0
>>>>>>>=20
>>>>>>> I think the client is written so that in the future it
>>>>>>> might have more
>>>>>>> than one switch?
>>>>>>=20
>>>>>> I wonder what would be the use for that, as a switch is
>>>>>> already
>>>> collection of
>>>>>> xprts. Which would determine the switch to use per a new task
>>>>>> IO?
>>>>>=20
>>>>>=20
>>>>> I thought the switch is a collection of xprts of the same type.
>>>>> And if
>>>> you wanted to have an RDMA connection and a TCP connection to the
>>>> same
>>>> server, then it would be stored under different switches? For
>>>> instance we
>>>> round-robin thru the transports but I don't see why we would be
>>>> doing so
>>>> between a TCP and an RDMA transport. But I see how a client can
>>>> totally
>>>> switch from an TCP based transport to an RDMA one (or a set of
>>>> transports
>>>> and round-robin among that set). But perhaps I'm wrong in how I'm
>>>> thinking
>>>> about xprt_switch and multipathing.
>>>>=20
>>>> <looks like my reply bounced so trying to resend>
>>>>=20
>>>=20
>>> And more to answer your question, we don't have a method to switch
>>> between
>>> different xprt switches. But we don't have a way to specify how to
>>> mount
>>> with multiple types of transports. Perhaps sysfs could be/would be
>>> a way to
>>> switch between the two. Perhaps during session trunking discovery,
>>> the
>>> server can return back a list of IPs and types of transports. Say
>>> all IPs
>>> would be available via TCP and RDMA, then the client can create a
>>> switch
>>> with RDMA transports and another with TCP transports, then perhaps
>>> there
>>> will be a policy engine that would decide which one to choose to
>>> use to
>>> begin with. And then with sysfs interface would be a way to switch
>>> between
>>> the two if there are problems.
>>=20
>> You raise a good point, also relevant to the ability to dynamically
>> add
>> new transports on the fly with the sysfs interface - their protocol
>> type
>> may be different.
>>=20
>> Returning to the topic of multiple switches per client, I recall that
>> a
>> few times it was hinted that there is an intention to have the
>> implementation details of xprtswitch be modified to be loadable and
>> pluggable with custom algorithms.  And if we are going in that
>> direction, I'd expect the advanced transport management and request
>> routing can be below the RPC client level, where we have example
>> uses:
>>=20
>> 1) Optimizations in request routing that I've previously written
>> about
>> (based on request data memory).
>>=20
>> 2) If we lift the restriction of multiple protocol types on the same
>> xprtswitch on one switch, then we can also allow for the
>> implementation
>> 'RDMA-by-default with TCP failover on standby' similar to what you
>> suggest, but with one switch maintaining two lists behind the scenes.
>>=20
>=20
> I'm not that interested in supporting multiple switches per client, or
> any setup that is asymmetric w.r.t. transport characteristics at this
> time.
>=20
> Any such setup is going to need a policy engine in order to decide
> which RPC calls can be placed on which set of transports. That again
> will end up adding a lot of complexity in the kernel itself. I've yet
> to see any compelling justification for doing so.

I agree -- SMB multi-channel allows TCP+RDMA configurations, and its
tough to decide how to distribute work across connections and NICs
that have such vastly different performance characteristics.

I would like to see us crawling and walking before trying to run.


--
Chuck Lever



