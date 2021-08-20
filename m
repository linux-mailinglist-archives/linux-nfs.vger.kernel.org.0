Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2D3F2D91
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Aug 2021 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhHTN6x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Aug 2021 09:58:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50694 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231854AbhHTN6w (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Aug 2021 09:58:52 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17KDl3wZ022950;
        Fri, 20 Aug 2021 13:58:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=d2uAmp6aXGy1P9jZknRo+161IXmI8dBlSMNlAMQ7hoQ=;
 b=K0MmhB67X49DtNQOFoNE4He8ptkgRblksLPveIeaAYXyZU6r2GukKEUHIfh0uRuoQipX
 6919aIcYb/8JssAUp3BbVhGyj1dM7zuk54N0TuLU/Dn1+lmVmZCkoziuK/XRW6VRDKQY
 BcrskRHcwZu9Kp+Wv6jmEjNO84eFmZWo1inWpfWojphV3q1VlInzta1jjkETlH0hKRnu
 Pe9hH3eOpT9CL+bprr1CS7HM2jlBojtr74GAJqBdFsAP8tcj1UU3CuwmMdoW14JtuJUb
 CBkGyskw4cGKcM6xBpii0ny+gI6/XIrLfV/WGGzQLa+i0unW+snXenX0U57eUW8+4Qlb jw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=d2uAmp6aXGy1P9jZknRo+161IXmI8dBlSMNlAMQ7hoQ=;
 b=k8PFgZDxNvQYsl6syEOLetG1FybdMf21WeksmGA0e4er+ABBg0318wo3nDjA5KTNta2z
 LMAllwKZzwfzYiZ5gjJwk2afy4PHXK5leguO8rfGq7LHLLbUDnrI7uGx6ulm4FKSZdSw
 C3mloCO05QcXVBT4jh9/GMGapJ0ODl+ObufJmQJ6cN70f/iQA53a9AT8fGRGB0ppJB2z
 z1Jmydvpff4dQPcbEJPl7NQhIn07FmfkpmV8W3WyoNwa8j/dQ/TXCs0RCLFsxvz8Y4T1
 RcudOrrTuUFEecY3uKa5ThlhSLkxWNasmVXz14eP0xX0O/XdzYS4Nlif8dNIL3Px9fl9 6g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ahsxd2cmn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 13:58:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17KDl0qg092746;
        Fri, 20 Aug 2021 13:58:09 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by aserp3020.oracle.com with ESMTP id 3ae5ndn1yx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 20 Aug 2021 13:58:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyNns/GvfYhUi63NQw+6aZUgtCOdeYEyl2BkgVZSZQbB0N2L+nf7PKeUi5cam+VO/Ww1JiSah+dExZgTgfbUJoRtf1RfhoI+ilGcQw4ZgOiWcu5VX8VwUNplD5upAYm02eMClPhCdAU11KifMhZIyFpO3Ph43VCNDAsZZQD2KN1sIB65JCvCjUe3oihArUUfQhgaa+aJ1rc8Di/Hsw9Q8gT/LvWejyVBVR/D7dokfuaegz4w9gaW5A0hyzqrIqmYCANMf5GE8KvP//ihJL9tZ3i351fVXDzBnvdTYRR7LYwVkq38uPEHl4Ydg2TTUHDHElkXYCAKoUCmsTBieIqsmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2uAmp6aXGy1P9jZknRo+161IXmI8dBlSMNlAMQ7hoQ=;
 b=lDz7klKi/tHf/ooAV1qiyeniEKwmSFSLyxwGphbbr4lR6R77ZM6jZdZtHUCMuDz2b+eQjwR6jwVr5akor9Vwn45HnNOcwNUN2HgtBwk1UoL+UcgwaxbMMdXw/i+eWtxeNvwSx9nGgyQpnrJeqdjpjeBbeh142NK7blMkllEuZk5Rl7fW8x3Rd9ZJWogBeupY9wctOgHKrwmd/bAiCrwHliyqApBtO1RjaVksn/it01xpmdG/Y4npVPJmMkABak7fJuadhVTXHYHHT79dojbTXiQBgnIekYj8QJmQe9Wf2jzyztZcTpAGF8t8fcHMIXcfNL2u9KZiwxk6TlEHXOl1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2uAmp6aXGy1P9jZknRo+161IXmI8dBlSMNlAMQ7hoQ=;
 b=MolGOmjKzmWa7Dcu/gtLWCOU0FLrJQbKYlUyB+vBI6HF8k/ESnT5sUoOn4TvyQGx340ORv/RfRXu5zk0iIAu/MhPTKxF4AMzOlRkF8hXktnXg0mdfKD1mxOIn0wbW61FQ+x83fQGz/d0DYaqa2vDGKlg2iSypsVIQI/q/YfOBbE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2440.namprd10.prod.outlook.com (2603:10b6:a02:b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Fri, 20 Aug
 2021 13:58:07 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::a8db:4fc8:ded5:e64%7]) with mapi id 15.20.4436.019; Fri, 20 Aug 2021
 13:58:07 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Bruce Fields <bfields@redhat.com>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Topic: [PATCH v1] SUNRPC: Ensure backchannel transports are marked
 connected
Thread-Index: AQHXlPXcGICcXaW3sESgYQmy74r7pat6ysSAgAAEDgCAABBYAIAABaKAgACiBACAAOYSgA==
Date:   Fri, 20 Aug 2021 13:58:07 +0000
Message-ID: <B5C44073-6391-4310-B89A-FCF31A5A5E22@oracle.com>
References: <162937592206.2298.13447589794033256951.stgit@klimt.1015granger.net>
 <ed3fbd005a9a2e3a6217085ebe05e80cd78766ba.camel@hammerspace.com>
 <6D4FFB37-B5CB-410B-A3C9-AAC92F611520@oracle.com>
 <69e8d4c3ae302ba51a92e20c927006ad33b2486c.camel@hammerspace.com>
 <24B4FABF-C6D5-4FF6-89B7-68EFDC3AB415@oracle.com>
 <ff2b05ffaecf066331c9f74ed0938f86a0e5a4a5.camel@hammerspace.com>
In-Reply-To: <ff2b05ffaecf066331c9f74ed0938f86a0e5a4a5.camel@hammerspace.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: hammerspace.com; dkim=none (message not signed)
 header.d=none;hammerspace.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a4ab05a6-f8b5-4365-4039-08d963e289ea
x-ms-traffictypediagnostic: BYAPR10MB2440:
x-microsoft-antispam-prvs: <BYAPR10MB2440D760B5F27C1132AEB07A93C19@BYAPR10MB2440.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1cati6cVPUt9TnbVMejte6zniPwoR0zVGwfZ4oJmQ20lFhN+eWpDDvymiqj1bqTHzcqf9I8wK53L1D3mSVial3k7zLznDeQi4mpqaha0dnhVr+/mwCOOKK8mb5/cWLnbui58S4mH5Ln/gBp6RZXUjMU0X4sp3XYiNFeErHsKMUA8/aY6K5tUpsX5mE8wxBe2/woklRQFgcw1dO/H0546f7j0Xs2VKwwSCSdPBhQlvX2SACy7KC8jztCYdpmdJIlDn8EOecnOB+/Xv+7E+k4KuOVPSc+wsUGaKZ3yRjmPX69k9Nk9yqZPTVgj+AuKu8qL3yb0TqiDT93jQulrlSrUpdX4fqMpDCkG6iPtxhLrCV2tF7EW1X0/D8RjMBHdAVB3bAAqbGMVmAFEaDUACHYWXT2A0Zme9DueaokOm8WyKY3S9k+hD/V8krvWyo98zKknZOy3bzCzmnhEPzUDUSb0dfQgTC1k10Kr2XWRItmDbIo5EVKwAvjENqtL+UFJqH5STNA7t00g+waWNc6TW4NMO492PKKfDJyNi5S2s0DKCISaDvU7ImdfDYtAczyww2yD5hmX1v/GRWHcoCgewjc0Yy2wkcF8vUJHKQ1YCGDIk3/9TKKUvPU1xjIvbHGmMZqMviM9qUlwXucscNEmcj8Jjsbkj+YBr5E3JgLl1iwY/oEwtOT4TvR0ywhB8DfEzKEaK34eqilYukLtXBQ+jEF3+lWC+FKlz0FvxdPSlAYHJVizkhm/GWvmTYj5bcBNvErlBZzxtLDE1tSmKE5TX64Xo1ZeOP26hfPfzVUtIUatBhx9gSRDmvM7HzqUzIPgleKJDVWQz6Yy79BtWWSrimY57nWgbPGPPk3MNAlsTT+OLTk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(39860400002)(376002)(346002)(6486002)(33656002)(64756008)(86362001)(316002)(110136005)(8676002)(2616005)(5660300002)(71200400001)(122000001)(38100700002)(26005)(186003)(6512007)(38070700005)(53546011)(8936002)(4326008)(2906002)(6506007)(91956017)(66446008)(478600001)(66476007)(76116006)(66556008)(83380400001)(66946007)(966005)(36756003)(21314003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mEhccNjuWNvGgDcdIxP/uw0roT/Mapk4tcUpdxa/yhL764RebHoEXikzyDpM?=
 =?us-ascii?Q?tsoPsxOl2U2jnmagWP6Ek+RKH542U18ZRPNivwLPDE6dCWGz1kNHtOFyvTbY?=
 =?us-ascii?Q?RAjYP4pWlSjiwLgc3Dap757gkC1WmJ0xmmdtD4BND9/UzN6UkSxd0Qybc0Hw?=
 =?us-ascii?Q?KpWHROilJuvKJCeaS4dEKMJtEh8S5MMGpYpXw+El1OWJXVX/h4amvO2zwymQ?=
 =?us-ascii?Q?E8b3KpiQ2v3EBJnxGYph9ERZ2Dn5D5MKPf8CUFVzMWz0lXO5uZQ+bySMbQ4Y?=
 =?us-ascii?Q?6J/eydtWSWCyGWno5xkz7FqizJNu+g+z8IqY1cFlxrWAYmIFAEAoKpP9FU6s?=
 =?us-ascii?Q?3b2wlhsZVZtMLQTEdyydl5qA44kpS62PSl9/C3tr8WU/mdVNRVbZ+08qp7YO?=
 =?us-ascii?Q?8HZQvf6obkbt/obpqdl1Ls1VZ3/4HWtvZMknE8w6A/hBEi/h3tQzkSKVDBQK?=
 =?us-ascii?Q?Dp/ZNqB0tdsP+54Dnmu/s2xcxdDdGuAFub731oGl/e6MfqglZiE/gJOMZO+2?=
 =?us-ascii?Q?rz6xxUCa46K5DD6qJAyWOAhZu+HRNTygjvHXabzPxA+5v+qZRJRnYcNsWT6D?=
 =?us-ascii?Q?S/a8/OcjowJ40xA6941yTdgnAF1NLZ+20SWaPpQIRbu8jVP75kivJbnj8V7v?=
 =?us-ascii?Q?goozWNyRMr3Sn1ehcTR9VF+tbHyYFT0VHhqL9AYRwDpK18stME2bIMwzNYIG?=
 =?us-ascii?Q?ueDSqpNtv49EUxTDwc+CjdZU6vZ2DoNYDe/LtTznkcWbVGOeX1U0BuNhrbXX?=
 =?us-ascii?Q?M+uZIYFFuxeGOTkL459thSNcIVqWxHgpyZ+7j8eZBsaOJHctbKsaUa8nIxtu?=
 =?us-ascii?Q?wId2QpcFdjzOJZ/RRrBnf+SOCUTCf+fRLtYeICNvoNIw8j1MaraFwuOSRM3x?=
 =?us-ascii?Q?WPpNQA7McE6Vdckyo52F/86dZsK9eW61T9m7gvqwosc5Ni7cpeWt7QgGiKBU?=
 =?us-ascii?Q?8vyqNj0kFl1ZH1ASLOvSRyR6sWjEbtz9BXpTlpbYIuAKqNmaH8K3B9eCTpiA?=
 =?us-ascii?Q?ufQwvJHeQUzfSPLmyZpgA++A4t7INSH3WlkQDg3OZuvOLQBK0XT9XlqlCT5a?=
 =?us-ascii?Q?MEhRqkh0eZaKPT57qvqvPU9mddKhaBmKedJPeEBkAYHwjw9IuTf1JzVF9JZG?=
 =?us-ascii?Q?cWPK4VqWyAnVf6IBcD+fOxFj0AGII9YZM4+Jd8dmdiIjHXVbADCzT2kdKhT/?=
 =?us-ascii?Q?0+4mdnsE2QDvmeMGHCbOrqEGI90LSB2GsWbw2mbN3U8T0myDtHqN446cBzt9?=
 =?us-ascii?Q?qW1GMOvPtyKviav3yVAlbKS1kb7IfubqkDMoSPWsLcgIfQlyGVIwvscDYDmq?=
 =?us-ascii?Q?bSQuIabceUTmBC5KqEkcu6QA?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <62DA1DFB25F6C44199A59C467015BBEB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4ab05a6-f8b5-4365-4039-08d963e289ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2021 13:58:07.6229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m1nWOSwPvy7J0t/AfJGQ4wi1Mfc/VbwKR/1bBHkOfpjA2SJB9sT5yBdV0mUmR91lMcoifV6l8Y2Q0f3+ip6/6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2440
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10081 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108200078
X-Proofpoint-GUID: zJjIfkLQI2oMsnQjWP1xE3oRYnwVlXgE
X-Proofpoint-ORIG-GUID: zJjIfkLQI2oMsnQjWP1xE3oRYnwVlXgE
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Aug 19, 2021, at 8:14 PM, Trond Myklebust <trondmy@hammerspace.com> wr=
ote:
>=20
> On Thu, 2021-08-19 at 14:34 +0000, Chuck Lever III wrote:
>>=20
>>=20
>>> On Aug 19, 2021, at 10:14 AM, Trond Myklebust
>>> <trondmy@hammerspace.com> wrote:
>>>=20
>>> On Thu, 2021-08-19 at 13:16 +0000, Chuck Lever III wrote:
>>>>=20
>>>>=20
>>>>> On Aug 19, 2021, at 9:01 AM, Trond Myklebust
>>>>> <trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>> On Thu, 2021-08-19 at 08:29 -0400, Chuck Lever wrote:
>>>>>> With NFSv4.1+ on RDMA, backchannel recovery appears not to
>>>>>> work.
>>>>>>=20
>>>>>> xprt_setup_xxx_bc() is invoked by the client's first
>>>>>> CREATE_SESSION
>>>>>> operation, and it always marks the rpc_clnt's transport as
>>>>>> connected.
>>>>>>=20
>>>>>> On a subsequent CREATE_SESSION, if rpc_create() is called and
>>>>>> xpt_bc_xprt is populated, it might not be connected (for
>>>>>> instance,
>>>>>> if a backchannel fault has occurred). Ensure that code path
>>>>>> returns
>>>>>> a connected xprt also.
>>>>>>=20
>>>>>> Reported-by: Timo Rothenpieler <timo@rothenpieler.org>
>>>>>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>>>>>> ---
>>>>>>  net/sunrpc/clnt.c |    1 +
>>>>>>  1 file changed, 1 insertion(+)
>>>>>>=20
>>>>>> diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
>>>>>> index 8b4de70e8ead..570480a649a3 100644
>>>>>> --- a/net/sunrpc/clnt.c
>>>>>> +++ b/net/sunrpc/clnt.c
>>>>>> @@ -535,6 +535,7 @@ struct rpc_clnt *rpc_create(struct
>>>>>> rpc_create_args *args)
>>>>>>                 xprt =3D args->bc_xprt->xpt_bc_xprt;
>>>>>>                 if (xprt) {
>>>>>>                         xprt_get(xprt);
>>>>>> +                       xprt_set_connected(xprt);
>>>>>>                         return rpc_create_xprt(args, xprt);
>>>>>>                 }
>>>>>>         }
>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>> No. This is wrong. If the connection got disconnected, then the
>>>>> client
>>>>> needs to reconnect and build a new connection altogether. We
>>>>> can't
>>>>> just
>>>>> make pretend that the old connection still exists.
>>>>=20
>>>> The patch description is not clear: the client has not
>>>> disconnected.
>>>> The forward channel is functioning properly, and the server has
>>>> set
>>>> SEQ4_STATUS_BACKCHANNEL_FAULT.
>>>>=20
>>>> To recover, the client sends a DESTROY_SESSION / CREATE_SESSION
>>>> pair
>>>> on the existing connection. On the server,
>>>> setup_callback_client()
>>>> invokes rpc_create() again -- it's this step that is failing
>>>> during
>>>> the second CREATE_SESSION on a connection because the old xprt
>>>> is returned but it's still marked disconnected.
>>>=20
>>> How is that happening?
>>=20
>> The RPC client's autodisconnect is firing. This was fixed in
>> 6820bf77864d
>> ("svcrdma: disable timeouts on rdma backchannel").
>>=20
>> However we're still seeing cases where backchannel recovery is not
>> working. See:
>>=20
>> https://lore.kernel.org/linux-nfs/c3e31e57-15fa-8f70-bbb8-af5452c1f5fc@r=
othenpieler.org/T/#t
>>=20
>> As an experiment, we've reverted 6820bf77864d to try to provoke the
>> bug.
>>=20
>>=20
>>> As far as I can tell, the only thing that can
>>> cause the backchannel to be marked as closed is a call to
>>> svc_delete_xprt(), which explicitly calls xprt->xpt_bc_xprt->ops-
>>>> close(xprt->xpt_bc_xprt).
>>>=20
>>> The server shouldn't be reusing anything from that svc_xprt after
>>> that.
>>=20
>>>> An alternative would be to ensure that setup_callback_client()
>>>> always puts xpt_bc_xprt before it invokes rpc_create(). But it
>>>> looked to me like rpc_create() already has a bunch of logic to
>>>> deal with an existing xpt_bc_xprt.
>>>=20
>>> The connection status is managed by the transport layer, not the
>>> RPC
>>> client layer.
>>=20
>> If it's a bug to mark a backchannel transport disconnected, then
>> asserts should be added to capture the problem.
>=20
> It isn't a bug to mark the transport as disconnected. It is a bug to
> mark it as disconnected and then to continue using it as if it were
> connected.

Are you suggesting the server's backchannel logic should
look for -107 status after posting an RPC, and then recover
somehow? Perhaps it could put xpt_bc_xprt then set it to
NULL, and then invoke setup_callback_client() again ?


>> What is the purpose of this code in rpc_create() ?
>>=20
>>  533         if (args->bc_xprt) {
>>  534                 WARN_ON_ONCE(!(args->protocol &
>> XPRT_TRANSPORT_BC));
>>  535                 xprt =3D args->bc_xprt->xpt_bc_xprt;
>>  536                 if (xprt) {
>>  537                         xprt_get(xprt);
>>  538                         return rpc_create_xprt(args, xprt);
>>  539                 }
>>  540         }
>>=20
>=20
> Are you asking me or Bruce?

Fair enough, adding Bruce.


> I'm not much of a fan of this code snippet either, because it doesn't
> really appear to have much to do with the normal function of
> rpc_create().
> However as I understand it, the purpose is to create an instance of
> struct rpc_clnt when presented with an existing instance of svc_xprt.
> It does not currently modify that svc_xprt instance in any way that
> breaks layering. All it does is take a reference to the xpt_bc_xprt
> field.

I see that the initial addition of this logic was done by
d531c008d7d9 ("NFSD/SUNRPC: Check rpc_xprt out of xs_setup_bc_tcp").
It was later moved into rpc_create() by d50039ea5ee6 ("nfsd4/rpc:
move backchannel create logic into rpc code").

Probably the essential purpose of this code is explained by a comment
that was deleted by d531c008d7d9:

-       if (args->bc_xprt->xpt_bc_xprt) {
-               /*
-                * This server connection already has a backchannel
-                * transport; we can't create a new one, as we wouldn't
-                * be able to match replies based on xid any more.  So,
-                * reuse the already-existing one:
-                */
-                return args->bc_xprt->xpt_bc_xprt;
-       }

Is this still a sensible expectation?

--
Chuck Lever



