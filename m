Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6173351BCB
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Apr 2021 20:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236283AbhDASLF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Apr 2021 14:11:05 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60124 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236010AbhDASG4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Apr 2021 14:06:56 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131DOS1k077725;
        Thu, 1 Apr 2021 13:32:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XqtggANkVxbeQNAs10MX6o1dwYngg877bWAXK/UVVJM=;
 b=M0KTayXsHmAU+mlbq0q/WVRm1p2gudsHr7hnFQ421c2/gldtLQcKgq0HAzf7A8hLxnz2
 eShVLZBH+acByGvvO+2DnWHPJnBJnAI3LJsZjvfn96G4oCbBfSX8X0bs9d9utulBBcbM
 PAPoO5gvEwoZtvjvDCVjCsBJlGrzR3dYmmN/0JJrIl+XSqJh/vXOgNsSW1oSPO7quIw5
 Cc/HqD4HPw/jPBBjy1wrFDLldT0eE2szYXhHDi0oEW5oHN8C0TuuNdTZ/cti3S7oItK4
 5MqtlWE1sXkm15GkHiIARvXNWLfRmGoxIUOy/n9eLl5rFpPRXcwvVERRWBi/ioJ+CsAz BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 37n2a01t9c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 13:32:49 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 131DPbT0143349;
        Thu, 1 Apr 2021 13:32:49 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by userp3030.oracle.com with ESMTP id 37n2astp2x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 01 Apr 2021 13:32:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejspjpm4ZS+u2mz7VjeBYZ0UOxePuki9DHTxiATNPkVaz3QkzlPyG09i1nxKNnUkdq0pGWA/v88YFd3ayyUomKAaHUDG0gaz23LketWAVlULTZI7kHMtzLU3KCt16LeERT2/WFDJQ5N50YQIKolXZnyEFKF23H+Wn8uoXmOKP9ejloRKsUvD1oD0q3DAcPZpVkvHxDPf+up0qybXWHK12zi+P3U54QPNa8cqq8CXueQA0h6/eB295vM+Bg9SM6oJhXBmkSZI2FnQ+5e7Wzpy8KEsv2RtxvSj+DfTtC6lTRaMA5JZUIwto3fWPIqI/eLEZ65s6ybo3uQxsSx/72/rEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqtggANkVxbeQNAs10MX6o1dwYngg877bWAXK/UVVJM=;
 b=eHlyAKXlU/xy/ry15jKjx748ZJ8r7QAoRSFsvFiWD32Tr74oWhHvNO0aSDPwhYFlOKjDtxMjKo8NXyBJxoTlFfGqd7jAO/CmpxJQyXWvHE5YWcaQjgaEf8nRxccvzbvEvQhnerVlUsvgSVUn4HE1xuyzsBzubGsO6Pz3nkIPx63/nPhZyU7tcL48dkJkHKBSGvkddgOU5+UkllxDA1EVqNX32cGVIqfOBHK7O/MdtEjBembiwTmaScV48HlJxgjobLPQPF008k0OmM7BnVzokk7d+fmbMqG8cmWwlEs5/BhBeH91foYVs7m/TY9GSCvmwWJ7siEClRygwsDqXoqUqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqtggANkVxbeQNAs10MX6o1dwYngg877bWAXK/UVVJM=;
 b=x9fz4+r6OP3MhKZNmERdyJUW85NfD/TUK1NE+WaN0Co6xuDiHu6CsrjH4qAXjpXrH4B6nsR52AeY1zcJIk+DuWXqIqWJ7pSPFEgkjJGzbudk6HcvOWZsl5HhdwkyT6hbVOvqoVAYKv/1XWn7I0gsoB7tDi+EGTAiphln8cj+0bE=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2757.namprd10.prod.outlook.com (2603:10b6:a02:aa::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Thu, 1 Apr
 2021 13:32:47 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.3999.029; Thu, 1 Apr 2021
 13:32:47 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Wan Jiabing <wanjiabing@vivo.com>,
        Anna Schumaker <anna.schumaker@netapp.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "kael_w@yeah.net" <kael_w@yeah.net>
Subject: Re: [PATCH] sunrpc: xprtrdma: Remove repeated struct declaration
Thread-Topic: [PATCH] sunrpc: xprtrdma: Remove repeated struct declaration
Thread-Index: AQHXJt1tLMsicTn0z0C3EtS8D4Tr3aqfqUUA
Date:   Thu, 1 Apr 2021 13:32:47 +0000
Message-ID: <82C3737A-E6CA-469E-B159-85DBE3657221@oracle.com>
References: <20210401095658.1006341-1-wanjiabing@vivo.com>
In-Reply-To: <20210401095658.1006341-1-wanjiabing@vivo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ff4671ff-2d5a-4c13-6f6b-08d8f512a38d
x-ms-traffictypediagnostic: BYAPR10MB2757:
x-microsoft-antispam-prvs: <BYAPR10MB275773AE7D70596B13786057937B9@BYAPR10MB2757.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:663;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tus5RmgCM7eaRyXlc33paOWQ9wCLHM5lLBwaQvNJXfiOsW8xH8Fs2YfZX1MIv9BVOlsrQabeM8d6yWDTI/3iwyh1gM2rqJxObSej0+Kn79Zc2yt/FwdVsRnJAlX11s+Pe24ltpWA8sTazG60uVGdCpUPOS5+jvGXpLtrYyxUHmlVr4ryy+Ix7FGDJ8TT8hzobFLs/X4d4UC5Vvwk7HSc9bGsXyWJgcJyLOI4w458mjL8Eo7Wmpdld4ciCXNAky63uZWhfIbIbKTGsggcKkSTA7NlabZHKgUItusq0aqGsLZaP7P99811XvxztVD10l7zC6qNL30Inx9qwNVoiEpQGiGUn++os9etMrlTb4cMYGagBOFfkzLpMGPpNl0iaQ+7SAWwTacoLeQAjJ+teu6z0NY8hz9hjjmFaFuCQpkxbqOvUpVPTkOYB66QLP+tjMJt6HKskKWD9/W+qqZR/wDib323jhyd/2+ZgflCpn5ZobZ8f61FAge7HR3e3VsypYKcyEy3bKCHGSsQVTtcHiqkERl1+YlulQuKTr/oIcgDnZy87xs3riHI/+9T9FdyFDM6G6z3N2XrGSOnhESvLgJuyCo9sGEsmq2N5u1xguFIxutdaetu+vEX2Lv0GTkbiPjMpvB2JMhlHiuy71lOPZ3fDm/1ClRB4/bFm6PvOKUFLycC3PdsPTophAFOBsuxFNAG
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(396003)(39860400002)(346002)(136003)(6486002)(66446008)(8676002)(86362001)(64756008)(2906002)(186003)(83380400001)(53546011)(66556008)(66476007)(6506007)(6512007)(66946007)(76116006)(478600001)(110136005)(26005)(316002)(33656002)(8936002)(5660300002)(54906003)(36756003)(2616005)(4744005)(4326008)(38100700001)(71200400001)(91956017)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Pi6TqPQ44OC67CvvnYWM63fm/vzmIwDZ6Rk4PV0ZOa5OjF0ycWFjV0WR1Y9/?=
 =?us-ascii?Q?yaUKUAt4cfH5HDkpfE2DMWilYOio15ZkZnCpT8iRnlvDxCOhzdyjfOEZyB5T?=
 =?us-ascii?Q?Rl9WnmYTfTwcEZ8u+XhvSIru34i5dAhVWdjZ+p1zbL6A8IkWGeddji5vT9iN?=
 =?us-ascii?Q?b4yZcYXDl1SlQZOEJLvOeFWvT9lmt2TbH4vQGwIlaRW0j+Gtzkei6eXmuL2D?=
 =?us-ascii?Q?XczaAysWAVMTWkjyCMwWdcrzo/UGpEjg0DsU0siD6VTndzj4mrCn2VqYTsCJ?=
 =?us-ascii?Q?e4oCuBI5a2+sA2b8nSagojU2aV6GySSw5Upr3yMyTctszhirY5ykBygSmrZ5?=
 =?us-ascii?Q?jTaEDazPgGEyAoHKve4INkZ1Qk6PNhYnajofJHW11X9o6jKLSNOus5+/2l9k?=
 =?us-ascii?Q?jq2nWO2CCA75URt0erTj0YgayLk0cDqbf25nckh+RlcrEhcBO7bl8B6wvLPj?=
 =?us-ascii?Q?X2DNGojSikKW6YSYuV4YLL0S1Sl0tFqdHnF4gq8iC8OMBiQNCEFw2D7J91L9?=
 =?us-ascii?Q?zThsdcxngmM5pT0UGN1ghN91jbgRMsg5QUhCY/OwqHGDOVjqTHGfRwKl/sye?=
 =?us-ascii?Q?SuGmEbvB0Of30a+wuKKiWDVQcfSMLdJTs/ZdEg/tsAHwbBWQff4Pr67TCU5y?=
 =?us-ascii?Q?9lHedGC0HiV4uyNnRd5CUSvwt8ULpRMLFrf/v2myEcB7Rq/Mv3GJhCV/eitJ?=
 =?us-ascii?Q?hXnRZ6R5WBgZtE+HLDLYtUWFAPvgcoQCvAWao3GsQZoC5uXiij7Kn48Pk4HL?=
 =?us-ascii?Q?P2hKAIMchtWGYkwfK5qzrbvYz+Vuwo2KvDpIJ0jdarMqs4PRf9+FFSf+cKH4?=
 =?us-ascii?Q?XPpzAssbTHNGatKqGZPcacPJfC5kb7MYxiepe8EsKL12qhViRWxj0aEy9/Fl?=
 =?us-ascii?Q?dEPxznLCmhWd0skPVZrhfeiiMPo+fNJFsiIHqEYoa5ZSh4cCrF0slM6AVLv0?=
 =?us-ascii?Q?++lA82JlCf20b6Rx/xsgk7Ok7XsilrozZ8SpUvcK+vafJzW4E4kcwFkqjsLr?=
 =?us-ascii?Q?l8pV4w7jl3rM+V5CJJhfrUSuPqR9fwN588xkZsrCg3ohxCJ6+N29ErmOVaT4?=
 =?us-ascii?Q?Rc8s0ZrXOb2mrO+SmQ7wEnq3FxSDpKpVaeQiIAMbUQXBrdUtLq+pbStgb7c3?=
 =?us-ascii?Q?tSZNOkTwtxmQXtlRf5MbJtLSFPf2OhIjIK18/5vA+U+VrZ3YGjFvGMihHQRp?=
 =?us-ascii?Q?Z+ikGW0lbLCH6NpXyZq0+7nUP8rLYhiYQ93MgcC1mnVOGrf0hJj3VIguNtRx?=
 =?us-ascii?Q?9eQnjYuYctmfjl8j91bMJrKvluHi3yR0MKCYCRdXNjoH0O1oJ7t1IEMoUHhu?=
 =?us-ascii?Q?n4cHL0iNmihEVaNaDARPu3/B?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D9D94FABC7700542AF3FBE31696FF086@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff4671ff-2d5a-4c13-6f6b-08d8f512a38d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 13:32:47.4439
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LRZEB9HQpSQuaX89+3mvywQmFW8cseWV4npZBviWT5/joqx3m/3Tk8HEppHi3ORlTZhz67RSLxMCWh1tzCTGWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2757
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010093
X-Proofpoint-GUID: C2VwmGDcXK9Qh-1l3lCnxQwRqX3XqeVr
X-Proofpoint-ORIG-GUID: C2VwmGDcXK9Qh-1l3lCnxQwRqX3XqeVr
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9941 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 adultscore=0
 clxscore=1011 mlxlogscore=999 phishscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2103310000
 definitions=main-2104010093
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi -

> On Apr 1, 2021, at 5:56 AM, Wan Jiabing <wanjiabing@vivo.com> wrote:
>=20
> struct rpcrdma_req is declared twice. One is declared at 216th line.
> The blew one is not needed. Remove the duplicate.

s/blew/below/

>=20
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

Thanks! This one goes to Anna.


> ---
> net/sunrpc/xprtrdma/xprt_rdma.h | 1 -
> 1 file changed, 1 deletion(-)
>=20
> diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_r=
dma.h
> index fe3be985e239..11e5fbfc642c 100644
> --- a/net/sunrpc/xprtrdma/xprt_rdma.h
> +++ b/net/sunrpc/xprtrdma/xprt_rdma.h
> @@ -239,7 +239,6 @@ struct rpcrdma_frwr {
> 	};
> };
>=20
> -struct rpcrdma_req;
> struct rpcrdma_mr {
> 	struct list_head	mr_list;
> 	struct rpcrdma_req	*mr_req;
> --=20
> 2.25.1
>=20

--
Chuck Lever



