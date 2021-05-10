Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6214D379814
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 22:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbhEJUBp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 16:01:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46444 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbhEJUBo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 10 May 2021 16:01:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AJsmgm126828;
        Mon, 10 May 2021 20:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PkMsDgvUmsV43e3k43JBUJfv9KLXumZEgw4Cn8yBmds=;
 b=ih8Fe3wY4rK1Z7bhc/+awGS8okm+fIiXzqaGrx9v+Adsy6oskm9YbL03qP75dLOXcUWh
 2WxpYdtAC5Y/uj2Ji7wennEVBTXkvQpJQlh5bx/ysvUfurcxabjIIO7pCckQeyj4BBxY
 t4I0I0g8oIPp+zp3oqEEwcO1Vb7RTplFY3sXwz6qSqxjomPmZZaDcS6iGQueaqokPrn8
 V96iPraphkGfKi8thqT5eMmFJQmQ+7s5Vf+MvDxzQd+AcuwaseJwtCqkH6ddkNw3jKdF
 wFjwH+LsL2QpVY7fShE9jsk1gZWM5gURi3GxO2aB/Zjc0lgN2UhlWPgf/puFisB/oWaL qw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 38djkmcgn4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 20:00:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14AJtmPs194057;
        Mon, 10 May 2021 20:00:34 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2177.outbound.protection.outlook.com [104.47.73.177])
        by aserp3030.oracle.com with ESMTP id 38e5pvwuca-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 May 2021 20:00:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMlWlY33Yk2GxooyPA1KQPUhnGffzUFDutlXlBrasAw668RvOlre74ae7RGoBTJhYi2PNpaQDUPSy91yL7yr8obssi0bK8kmVeqwVH1Xe4LqrWespV9emevRXbCKJAeEHZIFBAMysOqndk/0wqxlMa5jIaqRuBsYCG/kA9pj4w4CDK0lKRyP1pYi4x9Wr9SFYSIpH82xLnloRkbQoTqsr4gfMO0STpwI5boPy9p1SsIvkwjLJB1n0hLOiJ0ULh+9LhgQIOsYvwKUVw1Dpa+WkWbBNPonDqOCutXAE6vBthsyUGGcldtvuAyUFGqQKyFNU43cq9nhcTQDDXppzYS0qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkMsDgvUmsV43e3k43JBUJfv9KLXumZEgw4Cn8yBmds=;
 b=VOlQpVVz7aye8brwwzzV5EYJ7n8lxTuDZkHP19VmaltGXHFSgD6QTVcZXHuLuV5jRJZrxOSFzIey88f3+LE7sm4HnfJZW8FehU2B5KExJLSxzFLOA27AGnejffaNMeaxl0yvmRGqMsomCFqN0xudeisgfudebL1QX9lp6WwvfhUwsJyJ9mB4eXQF+Plz9wThLaBOjwj5x+KWZaJfh20I0w/0F3VvhIynpYEFzwDaCXUWEXN0ErPyUClXX55td2wMSsxz/mgBnTtCoxtl2p9CObXa6RfIvO/xzX2cSVUqT0G29AdiCcaasFnufb8h62e1Vjyp5b6rQ2rr7Gz9i2Wl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PkMsDgvUmsV43e3k43JBUJfv9KLXumZEgw4Cn8yBmds=;
 b=BxMKPFcLP0YR8BW5lXRyd1rmUYZQhF4aaKXxHrD1SCjwqymmwMsMdpLJyNcHtGHTqhqF2DpfthTehg9pD5iU49RsMvl/l+0K0AgslnubxUshdnLi7Qd0QsOD/WNib6JHkgWxknCtlQi/yCrG1p2+DvoxsAlRuwocyRjo9vFn56M=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by SJ0PR10MB4656.namprd10.prod.outlook.com (2603:10b6:a03:2d1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.26; Mon, 10 May
 2021 20:00:32 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::50bf:7319:321c:96c9%4]) with mapi id 15.20.4108.031; Mon, 10 May 2021
 20:00:32 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     David Wysochanski <dwysocha@redhat.com>
CC:     Bruce Fields <bfields@fieldses.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH RFC 21/21] NFSD: Add tracepoints to observe clientID
 activity
Thread-Topic: [PATCH RFC 21/21] NFSD: Add tracepoints to observe clientID
 activity
Thread-Index: AQHXRbSucZYUv8RjjEGtdKxv5mPBy6rdIasAgAABLoA=
Date:   Mon, 10 May 2021 20:00:32 +0000
Message-ID: <764E137F-7AB4-40EA-84DF-83C89578C865@oracle.com>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
 <162066202717.94415.8666073108309704792.stgit@klimt.1015granger.net>
 <CALF+zO=W1YgWXehHRKsrsBCZHe48qNwO=OMx7PQ_dJY7z+Tg-A@mail.gmail.com>
In-Reply-To: <CALF+zO=W1YgWXehHRKsrsBCZHe48qNwO=OMx7PQ_dJY7z+Tg-A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bf3b126-f5a9-4124-0bf1-08d913ee448a
x-ms-traffictypediagnostic: SJ0PR10MB4656:
x-microsoft-antispam-prvs: <SJ0PR10MB4656CB78867B0D4100BEE21493549@SJ0PR10MB4656.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:318;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e5WaVFIe9nJcihz3yQgGLpCeSJnAxmYxD7OsifCGu81VPb5QMrEwGAJgQzHM3LNvp2lYfqCKfVFo85Y+8F/tqUVZllFlB+/2miqYYGvbPob9ttGMq9aMPXjallOzxbWL7bQkzp2Ro2ubACnRERY3PODjE/0PESUk2ES/K94Rf1yxpzXvVvPeAevJsst9TrYcJrsB14lw1EJrVN/gi2bRzK9+BxeTiTf5lAG8wQh7eYCAexuuHqKPogu/BGBxff92XfoIk6/nYQuSMx080hWeUDoGkoRtEU9podnRno7gPXX1CLo9/0p2Fy4bl7D31QBbq3b/O46Mjzl7gb7aAdrcMG5CuMCMqA78DE+DQpmV7W4SSBsWZgD26QZTTrUUHz9fXexECA5+SKYsZrVw1By1Gn0aFuzDMYWKR36/nBkWGcFNjlBMzv7Uq9Sj20HkbJFo9OMfh0BjqlPLcvSqFvnXkil/g0HolXjSCXOoaJ35xTZrroHyyA2gvCMSPOZasxsARwWIDKtPRdm2PnuCm7WLlCkRouFoh2BaUYynav0f9KPeZndP3y+GNGAf9dgdefIswEZG3zCWy2D/oqiz86B/IdcGA43/bMFE12t8dkE48DdW+r+H4Vbrm3heX64DzH3VC7nktk6tSNi60SqA7vbS2Tmm/9gczgSt1R7HkmO1+N0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(376002)(136003)(396003)(4326008)(91956017)(33656002)(86362001)(316002)(26005)(54906003)(76116006)(8676002)(6512007)(71200400001)(53546011)(6506007)(8936002)(38100700002)(122000001)(6916009)(2616005)(45080400002)(6486002)(66556008)(64756008)(66476007)(5660300002)(2906002)(36756003)(66446008)(83380400001)(478600001)(186003)(66946007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6gEMinvC9NHx/5KsHFpF/sgGRRqkKJkpYX2fuhiqgXGRnYXe7OGbOTEMy/YB?=
 =?us-ascii?Q?SI4YM661ifSAzGvRRse4FWGZlCAxIXQ84RiIUxpbkauCXzl0UnAjEIoQFO9k?=
 =?us-ascii?Q?1nQNTfONRPpAiFlvHuYfzpTZb217Nk8SPEhzFcZxZysopd0Z2jM7k3HFTxqk?=
 =?us-ascii?Q?dETCZ4f2SX0JYzBInptKcIWbInNO562fcG1WxoMXyNMiBBQOMdV1ceQ6RzKc?=
 =?us-ascii?Q?kwXzLirBkOvimwesKHH2Zn2P2+Bt2LX3zl1CNhMTbiL6IBidc8lwXh0glc89?=
 =?us-ascii?Q?8rIBJw/eDyvnAUgJ932AzYu+nlz98yewlBV1dMfjJsLNi0Jt5HrKFKYiMtqu?=
 =?us-ascii?Q?6ikGatyx2g0daUld2Z1NGZvVoyprwayGSfVYqqvSLh21QcGyg9m7wWgLsEla?=
 =?us-ascii?Q?P7k4mX5C7TLSQyNH484iay6/+WOHiHpmrbKM74inHYff7ZREhxflT5lPMALX?=
 =?us-ascii?Q?b+VVwutrKWHJ664K9g/qTjg2oK5rP/59wNi/BPYFkzUvVZbEPPRYj//nP0S8?=
 =?us-ascii?Q?H3xYIMKxcDSivoFqX/u57RV1JbaUTBpEjJyL3867SM7V5Vds9f9zvkwkTUai?=
 =?us-ascii?Q?bBcmW59u8N5jwoIhk7XaLtZugrurSmsEaiZLc39C77lF96qdEaI5L2eJJ4qp?=
 =?us-ascii?Q?lT+UTOtlAMga5tqdxnk5wbh5mEfJ0bTiJkIAUsLfX7wNZLYqS/BShH0ebfs3?=
 =?us-ascii?Q?xHUhRhmbrey0DA5X5pTN8KHEeS/Amp6XCHcT/4WiYWXXJ2iVL8AgTwougMaX?=
 =?us-ascii?Q?nmInsIWT2ccZkGsYkPt02P7axv+eU7I0dIAA2BXX+gUnDGTOG6lep3VpaL3l?=
 =?us-ascii?Q?g0GGB/VtBaRpO3wKK6qZ1IGbR96eF2FPIVkKaCY1dmzeS8kFC37v+4/w/G5E?=
 =?us-ascii?Q?oec0ryf8ZHte2IUtZQwMr7/1V0gLPTtIuZ3mo4L8JFGf+DJBVe6b2aKGLmoX?=
 =?us-ascii?Q?oKF1muS2iXB2VfetjXimndGeSjHhz5soJ9xDLV5iVP2wutDD8OX5NsPJaYDy?=
 =?us-ascii?Q?SVehMJEcSFPQCT0fEn/p8Zz2tiFtxscUYn5YLElNKTmGpQdtb2Xa9YVsXx1H?=
 =?us-ascii?Q?JvWisXpfkxIiXo92CIt7p1zVaHd+CgEe2PQGiRpIJ3IcUa31r6Jch9ESbTp7?=
 =?us-ascii?Q?9ssk9KQIb1mtb3tV6txu+4YImFbOBIZySI6AINqV7/fMuqhmWf4hBqfHn2l7?=
 =?us-ascii?Q?o5nOWeWUN1c11KJbZNslDVmuByUtUjo2+V549opkcJsK7lyLLjvBv6XrCmN2?=
 =?us-ascii?Q?XLpPsmB2KeaeKQf1D3uJkEoTaxc2eeUNxd4Wwquy6NSB6G5N9b3aai71iQEE?=
 =?us-ascii?Q?qw9JMmKOwYFmDJ4DCGkMvqQP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C7D460F486E6F4E815FD045C827DCCB@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bf3b126-f5a9-4124-0bf1-08d913ee448a
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2021 20:00:32.1801
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zm+V/o/vRB05QntnV1rDdu8yhVsxVpQcMhGjZkqQ71AJcMCKcasbNcTBVcYjf+RIT/a39n/LFpNkN+NvoBjS+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4656
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 spamscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100135
X-Proofpoint-GUID: AYSUwrlEHQ79J7oiybgXZkwnrrSPr-dk
X-Proofpoint-ORIG-GUID: AYSUwrlEHQ79J7oiybgXZkwnrrSPr-dk
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9980 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105100135
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> [  408.223137]  trace_raw_output_nfsd_clid_class+0x175/0x1f0 [nfsd]


That's from the newest patch, so not surprising. I'll have a look.


> On May 10, 2021, at 3:56 PM, David Wysochanski <dwysocha@redhat.com> wrot=
e:
>=20
> On Mon, May 10, 2021 at 11:53 AM Chuck Lever <chuck.lever@oracle.com> wro=
te:
>>=20
>> We are especially interested in capturing clientID conflicts.
>>=20
>> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>> ---
>> fs/nfsd/nfs4state.c |    9 +++++++--
>> fs/nfsd/trace.h     |   37 +++++++++++++++++++++++++++++++++++++
>> 2 files changed, 44 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
>> index a61601fe422a..528cabffa1e9 100644
>> --- a/fs/nfsd/nfs4state.c
>> +++ b/fs/nfsd/nfs4state.c
>> @@ -3180,6 +3180,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
>>                        }
>>                        /* case 6 */
>>                        exid->flags |=3D EXCHGID4_FLAG_CONFIRMED_R;
>> +                       trace_nfsd_clid_existing(conf);
>>                        goto out_copy;
>>                }
>>                if (!creds_match) { /* case 3 */
>> @@ -3188,15 +3189,18 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
>>                                trace_nfsd_clid_cred_mismatch(conf, rqstp=
);
>>                                goto out;
>>                        }
>> +                       trace_nfsd_clid_new(new);
>>                        goto out_new;
>>                }
>>                if (verfs_match) { /* case 2 */
>>                        conf->cl_exchange_flags |=3D EXCHGID4_FLAG_CONFIR=
MED_R;
>> +                       trace_nfsd_clid_existing(conf);
>>                        goto out_copy;
>>                }
>>                /* case 5, client reboot */
>>                trace_nfsd_clid_verf_mismatch(conf, rqstp, &verf);
>>                conf =3D NULL;
>> +               trace_nfsd_clid_new(new);
>>                goto out_new;
>>        }
>>=20
>> @@ -3996,10 +4000,12 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct=
 nfsd4_compound_state *cstate,
>>                if (same_verf(&conf->cl_verifier, &clverifier)) {
>>                        copy_clid(new, conf);
>>                        gen_confirm(new, nn);
>> +                       trace_nfsd_clid_existing(new);
>>                } else
>>                        trace_nfsd_clid_verf_mismatch(conf, rqstp,
>>                                                      &clverifier);
>> -       }
>> +       } else
>> +               trace_nfsd_clid_new(new);
>>        new->cl_minorversion =3D 0;
>>        gen_callback(new, setclid, rqstp);
>>        add_to_unconfirmed(new);
>> @@ -4017,7 +4023,6 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct n=
fsd4_compound_state *cstate,
>>        return status;
>> }
>>=20
>> -
>> __be32
>> nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
>>                        struct nfsd4_compound_state *cstate,
>> diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
>> index 523045c37749..6ddff13e3181 100644
>> --- a/fs/nfsd/trace.h
>> +++ b/fs/nfsd/trace.h
>> @@ -626,6 +626,43 @@ TRACE_EVENT(nfsd_clid_verf_mismatch,
>>        )
>> );
>>=20
>> +DECLARE_EVENT_CLASS(nfsd_clid_class,
>> +       TP_PROTO(const struct nfs4_client *clp),
>> +       TP_ARGS(clp),
>> +       TP_STRUCT__entry(
>> +               __field(u32, cl_boot)
>> +               __field(u32, cl_id)
>> +               __array(unsigned char, addr, sizeof(struct sockaddr_in6)=
)
>> +               __field(unsigned long, flavor)
>> +               __array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
>> +               __field(unsigned int, namelen)
>> +               __dynamic_array(unsigned char, name, clp->cl_name.len)
>> +       ),
>> +       TP_fast_assign(
>> +               memcpy(__entry->addr, &clp->cl_addr,
>> +                       sizeof(struct sockaddr_in6));
>> +               __entry->flavor =3D clp->cl_cred.cr_flavor;
>> +               memcpy(__entry->verifier, (void *)&clp->cl_verifier,
>> +                      NFS4_VERIFIER_SIZE);
>> +               __entry->namelen =3D clp->cl_name.len;
>> +               memcpy(__get_dynamic_array(name), clp->cl_name.data,
>> +                       clp->cl_name.len);
>> +       ),
>> +       TP_printk("addr=3D%pISpc name=3D'%.*s' verifier=3D0x%s flavor=3D=
%s client=3D%08x:%08x\n",
>> +               __entry->addr, __entry->namelen, __get_str(name),
>> +               __print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE),
>> +               show_nfsd_authflavor(__entry->flavor),
>> +               __entry->cl_boot, __entry->cl_id)
>> +);
>> +
>> +#define DEFINE_CLID_EVENT(name) \
>> +DEFINE_EVENT(nfsd_clid_class, nfsd_clid_##name, \
>> +       TP_PROTO(const struct nfs4_client *clp), \
>> +       TP_ARGS(clp))
>> +
>> +DEFINE_CLID_EVENT(new);
>> +DEFINE_CLID_EVENT(existing);
>> +
>> /*
>>  * from fs/nfsd/filecache.h
>>  */
>>=20
>>=20
>=20
> I just got this oops when testing duplicate hostnames and having
> enabled these tracepoints with:
> trace-cmd start -e nfsd:nfsd_clid*
>=20
> [  408.119259] ------------[ cut here ]------------
> [  408.136659] fmt: 'addr=3D%pISpc name=3D'%.*s' verifier=3D0x%s flavor=
=3D%s
> client=3D%08x:%08x
> [  408.136659]
> [  408.136659] ' current_buffer: '            nfsd-1117    [001] ....
> 408.844043: nfsd_clid_new: addr=3D192.168.122.8:676 name=3D''
> [  408.136831] WARNING: CPU: 4 PID: 15097 at kernel/trace/trace.c:3759
> trace_check_vprintf+0x9f9/0x1040
> [  408.149530] Modules linked in: nft_fib_inet nft_fib_ipv4
> nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
> nft_reject nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute
> ip6table_nat ip6table_mangle ip6table_raw ip6table_security
> iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
> iptable_mangle iptable_raw iptable_security ip_set rfkill nfnetlink
> ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter
> cachefiles intel_rapl_msr intel_rapl_common joydev virtio_balloon nfsd
> i2c_piix4 auth_rpcgss nfs_acl lockd grace sunrpc drm ip_tables xfs
> libcrc32c crct10dif_pclmul crc32_pclmul crc32c_intel virtio_net
> ata_generic ghash_clmulni_intel net_failover virtio_console serio_raw
> pata_acpi virtio_blk failover qemu_fw_cfg
> [  408.176536] CPU: 4 PID: 15097 Comm: trace-cmd Kdump: loaded Not
> tainted 5.13.0-rc1-chuck-nfsd+ #12
> [  408.180288] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> [  408.182731] RIP: 0010:trace_check_vprintf+0x9f9/0x1040
> [  408.184912] Code: 00 00 49 8b 94 24 b0 20 00 00 48 8b 74 24 30 4c
> 89 4c 24 18 48 c7 c7 00 65 6c ba 44 89 44 24 10 4c 89 54 24 08 e8 e5
> a2 bd 01 <0f> 0b 4c 8b 54 24 08 44 8b 44 24 10 4c 8b 4c 24 18 e9 c8 fc
> ff ff
> [  408.192521] RSP: 0018:ffff888115617a30 EFLAGS: 00010282
> [  408.194732] RAX: 0000000000000000 RBX: 0000000000000013 RCX: 000000000=
0000000
> [  408.197706] RDX: 0000000000000027 RSI: 0000000000000004 RDI: ffffed102=
2ac2f3c
> [  408.200667] RBP: dffffc0000000000 R08: 0000000000000001 R09: ffff8881e=
3d20a0b
> [  408.203621] R10: ffffed103c7a4141 R11: 0000000000000001 R12: ffff88811=
0984000
> [  408.206571] R13: ffffffffc0ef9b80 R14: ffff8881109850b0 R15: ffff88811=
09860b0
> [  408.209537] FS:  00007fc70350b740(0000) GS:ffff8881e3d00000(0000)
> knlGS:0000000000000000
> [  408.212887] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  408.215297] CR2: 00005638a21aa9c8 CR3: 000000010c53a000 CR4: 000000000=
00406e0
> [  408.218245] Call Trace:
> [  408.219335]  trace_event_printf+0x9d/0xc0
> [  408.221041]  ? trace_print_hex_dump_seq+0x120/0x120
> [  408.223137]  trace_raw_output_nfsd_clid_class+0x175/0x1f0 [nfsd]
> [  408.225936]  print_trace_line+0x75c/0x1430
> [  408.227709]  ? tracing_buffers_read+0x820/0x820
> [  408.229637]  ? _raw_spin_unlock_irqrestore+0xa/0x20
> [  408.231710]  ? trace_find_next_entry_inc+0x10f/0x1b0
> [  408.233815]  s_show+0xc1/0x3d0
> [  408.235431]  seq_read_iter+0x93c/0xfe0
> [  408.237042]  ? lru_cache_add+0x176/0x290
> [  408.238722]  seq_read+0x311/0x4c0
> [  408.246280]  ? seq_read_iter+0xfe0/0xfe0
> [  408.247937]  ? vm_iomap_memory+0x1d0/0x1d0
> [  408.249705]  ? inode_security+0x43/0xe0
> [  408.251393]  vfs_read+0x111/0x400
> [  408.252841]  ksys_read+0xdd/0x1a0
> [  408.254279]  ? __ia32_sys_pwrite64+0x1b0/0x1b0
> [  408.256138]  do_syscall_64+0x40/0x80
> [  408.257670]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> [  408.259767] RIP: 0033:0x7fc703600442
>=20

--
Chuck Lever



