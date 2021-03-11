Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1455733768F
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Mar 2021 16:10:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbhCKPKZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 11 Mar 2021 10:10:25 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56054 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233597AbhCKPKW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 11 Mar 2021 10:10:22 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BF8xak015548;
        Thu, 11 Mar 2021 15:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=PXo9+ttiaAh8gett1ib1lTH1liGqjd9Rm+idd4b1o5Q=;
 b=EKMmnK/WN6FPqPwIoqYP/JBIQHxK9EOzjgfhQCUDlKkaouao+uJn61CCr1EBOPXm/dLq
 7hjY6Kw7K91cTYVKHE6OIYofTDFg+AT108kQqUr/zCe5soyT3eTI/Vyw79z3VUndG1Dp
 z4uzjsLlyI+kHOcYsoIgVvduXGw5gv6gFqkxFEakeHaYZ4SSxCRj+aGKOvdU67R6eaud
 AnJAUObQOrs/5t8vhU/DzglV4Kfyi7omHLYiXlC4Nzw/pnJqWrZ19JB5GJrxAiWbMBln
 5Ip6LWEjksaT3vl/zlIplgUJ81Uy4eTXs62WLfYUlCrjW01hiW3jdWU7f2UU2hrBZxVk nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 3741pmpw40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 15:10:12 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12BF9lhf118959;
        Thu, 11 Mar 2021 15:10:12 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by userp3020.oracle.com with ESMTP id 374kgv2kt3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Mar 2021 15:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZj4TeI3Rz4H+mnWPRcjaK1vGBjYkXO4iXs4Go61ltfwnr1tSUnIVa35WE61BrD4je7RWWC0P7Myxjr+QISQL4miAGMx5Zcm0PSfQHeSDbV1JH60CDb535cFJ4yIQ9fa66X/g+KRxxLdOeRDhnVaKrVTcAhX3fIvGB/3wldBqr4b1AusW7GRf4GNH+hF4IiduIkQib0x83HcaKwCImFC3k8LSm+oi9h+vgmBLT0C3/pAGb2Miw0L/+dH8gVdrhu25ye4N0cr7NPckXNztdYz1xwl25W5AjXJBP7S/fPsoDaHy0+G7ALNRmIwvaUZGMHt8K9jUlCDKgyKFJMucX5oaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXo9+ttiaAh8gett1ib1lTH1liGqjd9Rm+idd4b1o5Q=;
 b=cPhoUwu6K2vEsviXFCCNxv2oZa0In9y5TtKBgduStaOIAnZEaliVSX8HPOYHeYt2H5Dxkp1ii6w0bbml73/nkXFFj2Aulzy3yC7dUvwyjy6F5APosmGf8OCHEQ7kbMaVKz4zWlpi1/vMHd6+VBAkPDciNLFU/+fKeHnPcTKCVJXptsrzPB/eewPLP9n12qqUUpYLptUlpUQeY3VBLLCP9ErNLh9Pyf6VgzKz7/e2aMOg5G6J+TA45UF76VwXAdtoUWGJef9HDCXdXuLAfcYgqxkArnmuKW0IsyemNYWf0jI8vP8pZKC0az5w984O0R8LOOuQM9cQyQxKtXNCzpRbeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXo9+ttiaAh8gett1ib1lTH1liGqjd9Rm+idd4b1o5Q=;
 b=B3skyl8dPl0GOYKfLkYRKNdOkSxNvjnIDCij8wKbcEiF71pX7l8BCRhv2fe44DxsDmdFawlMh8z+jq8eu496+lVbDk2rSmSYXYJalBE9DG3qzsYuxWZaaW0eGkSKra0J6kuRCO3bOkougGmW2fCYH+Msqon3inpE7mT2P/gXzpw=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2918.namprd10.prod.outlook.com (2603:10b6:a03:8c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Thu, 11 Mar
 2021 15:10:09 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::6da8:6d28:b83:702b%4]) with mapi id 15.20.3912.030; Thu, 11 Mar 2021
 15:10:09 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
CC:     Bruce Fields <bfields@redhat.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 1/1] NFSD: fix error handling in callbacks
Thread-Topic: [PATCH 1/1] NFSD: fix error handling in callbacks
Thread-Index: AQHXFPJMATYPHlFtZkmEJfeeuT4DnKp7ykSAgABPzQCAAAVEgIAABRGAgAEqPYCAAHuCAIABHTUA
Date:   Thu, 11 Mar 2021 15:10:09 +0000
Message-ID: <2BAF1E3E-6FDB-46FF-8A63-0CA7EE5B6535@oracle.com>
References: <20210309144127.57833-1-olga.kornievskaia@gmail.com>
 <YEeWK+gs4c8O7k0u@pick.fieldses.org>
 <4ca27c770577376b0a39f0cfcfb529b96d6d5aae.camel@hammerspace.com>
 <CAN-5tyFttTHRdnELORJwCER_KPGBNk4W3eLwG0Z=QkwmPQh1UQ@mail.gmail.com>
 <d205a6a77273534666b3c33065934b9f66e7b103.camel@hammerspace.com>
 <YEjb9ZadFqa9Vu9O@pick.fieldses.org>
 <CAN-5tyFZ8fS6fjOJEu2NkRYUX6HrA5XNKPWyWN+UVtQT6Gp4kQ@mail.gmail.com>
In-Reply-To: <CAN-5tyFZ8fS6fjOJEu2NkRYUX6HrA5XNKPWyWN+UVtQT6Gp4kQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
x-originating-ip: [68.61.232.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 698f165f-2af2-43d5-8309-08d8e49fc2f5
x-ms-traffictypediagnostic: BYAPR10MB2918:
x-microsoft-antispam-prvs: <BYAPR10MB291859A719CE7EA95F6EC3D993909@BYAPR10MB2918.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1dgM0pRsXNGXP6o2y6+wz+61Vieh8gHxU17UZv3BD/SRLe9HbmhzBObZtwXbGY5M2a7EWEUOpoa1g8e+pGVBofalx6Cjxt0cwjjE7ok7CtbuHo7NN8zQymjDKOAjahZ5FivSuOHkqTyytfMHHklpthFKH9zkgg3FkKEqlMHv1hnLmo+AsaXzKOIB/4EsXRv87yei39N6zpBIMRDKk7f3pgWmHY/1jd1Ts7HU/8otsFF3vO+bop2oUCPfp13zc9brsdBjegIjUEuezyCToch1JUeZxySZ0pudRvliz/T+6N09f5T+gUB29EpBBcQ3d1j5WfkhsSB8xQFgUsvFOLEFvWshIRhTlPE4zbSfsSlEvEZM85TvKRuSt++Q1etQ0sEhh3idNwkQzAVt+zq4lJmP/cwJcnOKeaW0Rr72x7YUFkhwgYsujlUA9DEHt8p7GioF9lbwBHVHuL2cke9oeNIa5lrhEJIPB3kxba7HZsivjqXviZw05+aVdfctcdtXGbkeGsunfTi3VGPe37a9kmesj0032ac4XuHOuWFvU6iPgnLqBjC1O89J61VIYFgD2gxPc7x0bmBkcMFjDyv3O2dSVA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(346002)(39860400002)(376002)(54906003)(186003)(6512007)(71200400001)(478600001)(8676002)(83380400001)(4326008)(33656002)(2906002)(26005)(6916009)(2616005)(76116006)(91956017)(66946007)(316002)(6506007)(36756003)(5660300002)(64756008)(53546011)(6486002)(66446008)(66556008)(66476007)(8936002)(86362001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/SZIROQOtSJHnObdYI2YPgSWgju8Kple1MFGt833TMwwm+4ZHTd3e530tG5Q?=
 =?us-ascii?Q?K4iEYfCBLInxNIF1gJ4ZM681jRH/ZqGLbz7IEj/905uNlNmuAZdxOd6k+rzL?=
 =?us-ascii?Q?fBIvceIlCtyOk/7k2mVvOLlfwChASlMdTkTaN6dsyxAPpIo+MSBJ6l9PEswU?=
 =?us-ascii?Q?x4k8iFRTKj2Zs2U3yCKFuv0A6IYfFqgVUumSFUNg1SBTuRCLL/VzKCpLKQgG?=
 =?us-ascii?Q?XDZkxJnvMAhTD8qBxxlSH2Dn8EcniKwWlFiMdT0i4uVSqieRAzD7ooDiX8hQ?=
 =?us-ascii?Q?kyn/NeN4Gop5lFVlStJKN9C5A/UPGdHGHeJBD/UhCUiqtJuKZem8voW57SAc?=
 =?us-ascii?Q?SGFkyPp2eWI1QiuBB0t9VuB+9YdRqcbCpqmGxSP0XoAfRxoxhc8d9KdhqOeF?=
 =?us-ascii?Q?qhDO5Y6aIvlj3tYgqPe1h6BK4FJ3UwBndNwSkUTPduc8+vyvEpMS4Tzx9jGz?=
 =?us-ascii?Q?RbjnrxixAJXszwqa9FA4TjV3o1CVCXxOm65pmw3ghfwswn54PWvBSIihdFoT?=
 =?us-ascii?Q?uU3uutpzKhB/3WMO1y5otVJQ8QBJM1io09Qs2TZRv1tuTL9A/ZtqYfsUPLg+?=
 =?us-ascii?Q?W6VhcRIJ1SrwcMHGU1fm5s5gX9otavvWgF4ub2Ba5JkL+gfxMnmfxqGPCBaW?=
 =?us-ascii?Q?JYcvbnJBjppPOE9W7v39EmOtqc6xws+twvxroQDNhsiUSLr+qf6G0a5dRBjZ?=
 =?us-ascii?Q?z1WpuVh14LyuQhRtXLG5+y1+G+glyumN8TNA47xpJwaGwlnb1rgd8RhJ3/7t?=
 =?us-ascii?Q?7+Qw4pLfZd8Id2noNxS5/MUodV47P/6wkGeSOinTCUA07YGEVNsx1pZxD1QJ?=
 =?us-ascii?Q?xdd4V4hePEyV98gJrZ00G+pNYeMRVY6w52eckUQNQ1NkN49KelSkh+xHh5zi?=
 =?us-ascii?Q?+6I1fZM5XecaIcCIUOyJ7ouiP4zUaxbG0wCad+Ip7cNaO6H/1bNKogbNfzz5?=
 =?us-ascii?Q?7c9c2JB4Eop8k4HDHHNBbLMcvPPkwrh5tiKNcVZClIx/9IUrsE0SxajcMkZ5?=
 =?us-ascii?Q?A00dXtZvX8ya+U4f0fK27ZxeHpNJPlx+T2GN/MAg82jVXBfa2yduDX3B5lYC?=
 =?us-ascii?Q?aeiFRHn9Zh0e+ukVjWfgkUEtuBgVH6VsPAl96n8SjzpCBS1luug+QmI0glbd?=
 =?us-ascii?Q?0kOghLkaCafbohPvMwmEijPqw5qgJMXc2xG81HAVzqFFh5fK90eQLc5Ta2j/?=
 =?us-ascii?Q?6U41b1/N4oVPpM0IxrQpMvhVlu5PxmRHIbNFR++i+Ber8ALvVM9rniX6DZLs?=
 =?us-ascii?Q?RrPVatxMAGvyCBtH2qqKD+d5IQpU9Uf7n3C+S7yBqaOQIkfoXT8FIAB6xijG?=
 =?us-ascii?Q?6DRnthXxXcWmEozwO+YhTXgk?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6118E8DA70FB7745AB0E1FB8CA3939B7@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698f165f-2af2-43d5-8309-08d8e49fc2f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2021 15:10:09.4090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H1iS20kEEKezRk3CEDDKTa+wDn+3P4wXgKhIPUsZdlRJ/LNHyymzOXdfQHYWr0LomCycMAWMPRkiT5TpKhRyEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2918
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103110083
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9920 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103110083
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 10, 2021, at 5:09 PM, Olga Kornievskaia <olga.kornievskaia@gmail.c=
om> wrote:
>=20
> On Wed, Mar 10, 2021 at 9:47 AM J. Bruce Fields <bfields@redhat.com> wrot=
e:
>>=20
>> On Tue, Mar 09, 2021 at 08:59:51PM +0000, Trond Myklebust wrote:
>>> On Tue, 2021-03-09 at 15:41 -0500, Olga Kornievskaia wrote:
>>>> On Tue, Mar 9, 2021 at 3:22 PM Trond Myklebust <
>>>> trondmy@hammerspace.com> wrote:
>>>>>=20
>>>>> On Tue, 2021-03-09 at 10:37 -0500, J. Bruce Fields wrote:
>>>>>> On Tue, Mar 09, 2021 at 09:41:27AM -0500, Olga Kornievskaia
>>>>>> wrote:
>>>>>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>>>>>=20
>>>>>>> When the server tries to do a callback and a client fails it
>>>>>>> due to
>>>>>>> authentication problems, we need the server to set callback
>>>>>>> down
>>>>>>> flag in RENEW so that client can recover.
>>>>>>=20
>>>>>> I was looking at this.  It looks to me like this should really be
>>>>>> just:
>>>>>>=20
>>>>>>        case 1:
>>>>>>                if (task->tk_status)
>>>>>>                        nfsd4_mark_cb_down(clp, task->tk_status);
>>>>>>=20
>>>>>> If tk_status showed an error, and the ->done method doesn't
>>>>>> return 0
>>>>>> to
>>>>>> tell us it something worth retrying, then the callback failed
>>>>>> permanently, so we should mark the callback path down, regardless
>>>>>> of
>>>>>> the
>>>>>> exact error.
>>>>>=20
>>>>> I disagree. task->tk_status could be an unhandled NFSv4 error (see
>>>>> nfsd4_cb_recall_done()). The client might, for instance, be in the
>>>>> process of returning the delegation being recalled. Why should that
>>>>> result in the callback channel being marked as down?
>>>>>=20
>>>>=20
>>>> Are you talking about say the connection going down and server should
>>>> just reconnect instead of recovering the callback channel. I assumed
>>>> that connection break is something that's not  recoverable by the
>>>> callback but perhaps I'm wrong.
>>>=20
>>> No. I'm saying that nfsd4_cb_recall_done() will return a value of '1'
>>> for both task->tk_status =3D=3D -EBADHANDLE and -NFS4ERR_BAD_STATEID. I=
'm
>>> not seeing why either of those errors should be handled by marking the
>>> callback channel as being down.
>>>=20
>>> Looking further, it seems that the same function will also return '1'
>>> without checking the value of task->tk_status if the delegation has
>>> been revoked or returned. So that would mean that even NFS4ERR_DELAY
>>> could trigger the call to nfsd4_mark_cb_down() with the above change.
>>=20
>> Yeah, OK, that's wrong, apologies.
>>=20
>> I'm just a little worried about the attempt to enumerate transport level
>> errors in nfsd4_cb_done().  Are we sure that EIO, ETIMEDOUT, EACCESS is
>> the right list?
>=20
> Looking at call_transmit_status error handling, I don't think
> connection errors are returned. Instead the code tries to fix the
> connection by retrying unless the rpc_timeout is reached and then only
> EIO,TIMEDOUT is returned.
>=20
> Can then my original patch be considered without resubmission?

Bruce has authorized v1 of this patch, but that one has the
uncorrected patch description. Post a v4?



>> --b.
>>=20
>>>=20
>>>>=20
>>>>>>=20
>>>>>> --b.
>>>>>>=20
>>>>>>>=20
>>>>>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>>>>>> ---
>>>>>>> fs/nfsd/nfs4callback.c | 1 +
>>>>>>> 1 file changed, 1 insertion(+)
>>>>>>>=20
>>>>>>> diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
>>>>>>> index 052be5bf9ef5..7325592b456e 100644
>>>>>>> --- a/fs/nfsd/nfs4callback.c
>>>>>>> +++ b/fs/nfsd/nfs4callback.c
>>>>>>> @@ -1189,6 +1189,7 @@ static void nfsd4_cb_done(struct rpc_task
>>>>>>> *task, void *calldata)
>>>>>>>                switch (task->tk_status) {
>>>>>>>                case -EIO:
>>>>>>>                case -ETIMEDOUT:
>>>>>>> +               case -EACCES:
>>>>>>>                        nfsd4_mark_cb_down(clp, task-
>>>>>>>> tk_status);
>>>>>>>                }
>>>>>>>                break;
>>>>>>> --
>>>>>>> 2.27.0
>>>>>>>=20
>>>>>>=20
>>>>>=20
>>>>> --
>>>>> Trond Myklebust
>>>>> Linux NFS client maintainer, Hammerspace
>>>>> trond.myklebust@hammerspace.com
>>>>>=20
>>>>>=20
>>>=20
>>> --
>>> Trond Myklebust
>>> Linux NFS client maintainer, Hammerspace
>>> trond.myklebust@hammerspace.com

--
Chuck Lever



