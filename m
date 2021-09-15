Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA43540C6F5
	for <lists+linux-nfs@lfdr.de>; Wed, 15 Sep 2021 16:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237678AbhIOOFD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 15 Sep 2021 10:05:03 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25754 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237708AbhIOOFC (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 15 Sep 2021 10:05:02 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18FCv6wC018578;
        Wed, 15 Sep 2021 14:03:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OUOSHVgtZzY+VIrnfvy/gE3rvtJJz2QTQlywRd78xCc=;
 b=ywnxfvWmYtXoe4iOcGlLW+6RBGF3gZyBBqe4A44EFp1aCZGO/Ipilp4suFOoOBuiboH/
 KVYmVXwlqrzzhPelrGtcBKirU0eKb/Xymii9ABbJsw1JmWwt/thaVqBGNVF6XLrhY81Y
 B/PgsJTI8LpJz5j2GCFQK4BapgIBTBI1b/Y5mz/dq8hPjKWTkHtoToaD48gSUF5qX5Av
 W2k67tAb7RjYXWl1RcrwmIUhQg353+NDfwNgV1bvTtn1X57MeK6Kjj52z+nssbxPvQJY
 9eLFLbWxuDuOi0J2oMedWgHliF6d9zDQJ8b1b+Md0I+5995XMCxjmZhTm6CvR64sLpTb Aw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=OUOSHVgtZzY+VIrnfvy/gE3rvtJJz2QTQlywRd78xCc=;
 b=bw32PVpOx38VFr97dVikaG/BTP0aKAwCW77HIovN7LCvjCSyL4FBZ675WNqqX73D26/Z
 FexWI9Hk4VyNm1V3D4uJiZpPGvriu0BQtXSzSX8H7SWiBqAzXqEosE2sBothaOHPSZNW
 n6GXF6DSO3RMtuXNrRHLoILdjJkv5xaAh3hUdr4MI+dDEP3iqK+ID6jzTqjx3on2FACc
 CreYYdhEIS7PjBW0d0KpqlJWmop3eaSebHiVyHfzPW3Y4EFHJ1Fxwuh8wV7Sm0Nv1BtI
 /YL+U6LxV28ldEczUpQ20zkjj5JBti8fi9IbDqevrMIE8oUbcs63qnxdp/cItkmzu5ld eQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2kj5wfrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 14:03:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18FDncWH164212;
        Wed, 15 Sep 2021 14:03:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
        by userp3020.oracle.com with ESMTP id 3b167tq8h9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Sep 2021 14:03:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7lBuTIc/neTtr5ixDA3hlV/vQ7oG5ABRjACQ8HRne8VBvMJar2wDYuxT957auLC/bMSfyu+orN01rIkZyTH6q53XTe7AS2IzKD3NXmU4h35sZvFu7Yzpk0D5HK9mwiJZ5hwTWl/Oc0xkqbKkl3VNs1Wc2hLWUbnfJamY3V+GdoSDXKtGm9ORcMctgfQmEPZsY0175dQ93UlTJz2ApoE/7UUUIcy1XIpN+VJDrIv+dtEHDvfJbQjkytrLvdVghETiz2sr3Qml9GPEYMGG0FpeRek4EfJkVydXPleAIHlwnhfl1sYf6Q2AK5K0rymFsEuD9f/UPHolX7Wt7kjRY/08Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=OUOSHVgtZzY+VIrnfvy/gE3rvtJJz2QTQlywRd78xCc=;
 b=JmkyqJPQ2/OG4HafVkWrv+kQ3YZuA494dECiWcq28GKb1WC53J+T2PMf+n9VhkKStmdc1eCEfjIsNFSctsid3MrMl3sZzc+Lswt5svJo7Ff49shCgg1qidwNDlr8qh/Khdglz3eDBCa6ElQ5JmppIMBg5nMpEeo223qp7SSQvgk6iBq78+G+VcjGZlcr+qzJTOBMuGs6rpMkY/703OUDN2xaiiuqyPOc8amjPcYkDbGi9MeTgnXLmjEzya3yPNo0ncy7uU7BXovKm+2HWKNgy7q5USclXcmDLEMsQyQdLkMSf6FpBklSIrUv9UnND4auDRqZurohgYMZaS8BB0XQGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OUOSHVgtZzY+VIrnfvy/gE3rvtJJz2QTQlywRd78xCc=;
 b=LsMZDWlitddG6QK2bp2r5lx7O6p7ki9Lf+x8SLuVar9ClvNSYH/DyY4lpOD47PySLgekiO17d3J6QjwfEsDjOMQzACGTzuPJDEHHi5+6nP1pWfNtGgRG5szPHyZPJSGrL3NmBtmmqALiXt0s2lKcFksK8SipJFPkcGozUlJJdNg=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BY5PR10MB3859.namprd10.prod.outlook.com (2603:10b6:a03:1b6::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Wed, 15 Sep
 2021 14:03:37 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::f4fe:5b4:6bd9:4c5b%6]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 14:03:37 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Bruce Fields <bfields@fieldses.org>
CC:     Jeff Layton <jlayton@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Thread-Topic: [bug report] nfsd: Protect session creation and client confirm
 using client_lock
Thread-Index: AQHXo790A7Wd0tfa/0e3moKXgUhSZquYZ4qAgABDIACAAf4ZgIAAAbgAgADWPACAAEaCAIAABwqAgAf39ACAAAMaAIABZCWA
Date:   Wed, 15 Sep 2021 14:03:37 +0000
Message-ID: <43B4513C-F702-4FD1-8E1E-7CD6245A41FA@oracle.com>
References: <20210907080732.GA20341@kili>
 <deba812574c9b898f99fc08f0c3fa23e85fc36ca.camel@kernel.org>
 <622EC724-ECBF-424D-A003-46A6B8E8C215@oracle.com>
 <20210908212605.GF23978@fieldses.org>
 <23A4CB30-F551-472F-9F2F-022C40AE1D70@oracle.com>
 <b63e52660e39cc7688921f85eadf1958ced6a869.camel@kernel.org>
 <57B147B6-FC8F-4E70-A3E1-D449615B8355@oracle.com>
 <c72e78075bcdc174e5786aa6678655fdae73eaaf.camel@kernel.org>
 <20210914163750.GB8134@fieldses.org>
 <6BFF777F-FD2F-4950-BF32-E2DC69C3C713@oracle.com>
In-Reply-To: <6BFF777F-FD2F-4950-BF32-E2DC69C3C713@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: fieldses.org; dkim=none (message not signed)
 header.d=none;fieldses.org; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f658a59-6684-408a-e8d8-08d978519d79
x-ms-traffictypediagnostic: BY5PR10MB3859:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR10MB3859C2A6DB5F3B4D59223A8393DB9@BY5PR10MB3859.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AZu9buAH4ekEy17NeDWSTfZ1e0PPsJYzgLSEeiL84GSq8ZlWMx+/g8UIdoSdsEoj0JzyX+YfeU9Sq/IKhZ/BDijS8lazp33wJhf3Ab6XyPpoqOMNatFJ4+0m/7Eo/2+VL5GgMZhy+yk3n9lOFD7C/g6IabPBCt+tH/gL9+qdLfN/wQazycfUEE5rbL2umpmPAHIuXuS5Ts/BNvtEb8u2ILKvVdfO17a2Gjpk7HF3DbYwPN4fJrP8kHolZHg5023GvlS7VJNtgSo8JdMhcEWe9Ph6SFtkxVhNQwHwS4f26bRnpQVixHkMVb05tZZL/xsZ7cvNwf4jAWDIjBfmJfJr5B+eUmgjiA1xpjm83sg4fbyaizPDcWKPyxDg48vomJXG30B7iHKobTMxatEjloxZQrESpDFhvQeUIBCMswdDA7x1qnnByYggwbTYfFy6JBldEtuKkPzOODfAK4QEq2v2kF9R1sydiOqi4AsyPl3O7fsQLZ91UkuE5Z+gO+t9DgW2IC6jRzmHQVBJKlwH9q9eYue6mNNav/sm+FBsjbE+qSuo0GuXr1Yb5A4rWFTEzljNfECpsuAbivKbnsD0r5VMAHaWyvltFQYPtulC6c7hPOK+7Gp5mvA0QoFa6QMDomY635PUYYlWlwXVZ+u5B2Ax1bnPKpMcRMrUrV0/akouO7heIUHgxAJimdQsiCLapOK+evHH7ZkDdXLoh9pxLUCmZa/L3B+DmB4XRu1nzWLiBtGNcnb3riqk1xuPOii0b15J
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(396003)(366004)(346002)(376002)(33656002)(66476007)(2616005)(66556008)(64756008)(54906003)(66446008)(71200400001)(38100700002)(83380400001)(38070700005)(53546011)(8936002)(86362001)(186003)(5660300002)(36756003)(6916009)(66946007)(6512007)(8676002)(26005)(4326008)(91956017)(6506007)(2906002)(6486002)(76116006)(478600001)(316002)(122000001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ey7HPsUHQyVVHAq+KN+Tc3eYlOTSvRpnQV20G547/exxg2mzpNoQ+WUGGLF+?=
 =?us-ascii?Q?goJlus3WYwpZeIXsZ/VKrx9CO3jLuhIOPsyyaMERvKk0aJnd0lmO8eHMUPK6?=
 =?us-ascii?Q?GnmhlXU5AYWqBMQMal94DyWKsR0+tFiPJXpGbd775i2TxeRKFWiHpaR+V2z2?=
 =?us-ascii?Q?0Q6+nzeeLV1UIwYhlFNqzwekzL5QAKb74yWpMTreBGcVy1zIIwdJhBdsnB+T?=
 =?us-ascii?Q?X7Jftg+DQi29aEAHZyIyxeU/gs6L72HkFzR0GxJS1EhYMrAWEhujZXseh/o/?=
 =?us-ascii?Q?e/So1qQgGNEZEXH3CPVPN1JuI34c/c68rPpA5Sw8r0TMy+n4tYmKjUE7cj/v?=
 =?us-ascii?Q?F/3E9U3aja7t8XogRCFCejxto9LCbvUBBSDZjJtZyvQ6/qGSjt0VfvZPeya/?=
 =?us-ascii?Q?IC7CwzoTmiV57IIIEuK4YECAx8zFigPaGS5e0BTRCF+PS9JDDg9ASY7UGcjZ?=
 =?us-ascii?Q?JJhAq1YUlZaIyNgZLpc8ul+KtfDinXroj/9NfRCBOjsgTfnJ7xzrrxmog0s9?=
 =?us-ascii?Q?xLbuzPSeOnaKZEFYmtypUN6qi81JYvLqpnRx1ypo7TOTkDKy5YtnU6UTSWtJ?=
 =?us-ascii?Q?P23srYLz0o5pidLEFpJgkSP/Pzyfl0026DYqTk1q603nco1UyiVhCZIomVW1?=
 =?us-ascii?Q?eAXnte5TlLBaYdtanZpEBjmnlEInCRNoYaxcl4AJE3HauTTs6eoNnlrWM2ye?=
 =?us-ascii?Q?wSwki2RMOiJocFW0INXo/uJUhO+/ZPlne7YP3KSaQLfaie8QmU152090Ui5O?=
 =?us-ascii?Q?5V3IFX5OIJ/6BMZSkP0C+2WUsG0CpXeZX8GA0nkEqWADzJE1AyAA54u1tX6J?=
 =?us-ascii?Q?T3vmIc1G7S7a9IXthmntB5fL1qP4npxPBtRV0yJ1a+wud0v11qqJdvq+u3Ca?=
 =?us-ascii?Q?YbHZ23Mjfr23wkOoAlkWU962notlQpNkp3o3bNf1+MKU+IbozIUmyIS5Tvzt?=
 =?us-ascii?Q?WmqZTv63ODsO2XnSer9l75m1XIKoEI6NzXsDCJ98lJkurTBykMAKXU5cD9ik?=
 =?us-ascii?Q?RsN2gnxfkPYH25PFN6BCl6vxD35iN7Z5bC/FmoeO5ZSezQdJY7yOUks8ak4L?=
 =?us-ascii?Q?p1VLMGutH0xDxPZ83GdTEUx2W5520DhSDTrJ8dps2o0nx3tnMM2UXbK21isq?=
 =?us-ascii?Q?chyL1vDSWScBDFGtehBPG5JiawI6JfUel2Rcj1HvP3CAaJimrGbMijwF1cCL?=
 =?us-ascii?Q?M+3vuiwASf4O+kvM09CGUVZXAmjuLnbnQVYPKM9aK6FJMY2xEpDjf1fyUacp?=
 =?us-ascii?Q?+8AYROMEhzINKoqhbUjKa9eBY2xbS/jdpkQKzU98cR6Z1WHE01N5aZaHwLCR?=
 =?us-ascii?Q?N4OxbNoYE5tc+XfDsD0o7RP4?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E942BD71FC729A42A7E517E9A73B8574@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f658a59-6684-408a-e8d8-08d978519d79
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 14:03:37.7938
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ASHhQMdxVC31IHMCjYsHCzs19Btwo5716k5fodNn7mRQj4hfkMD30IAW2JL1IKPdvxLjI/tq2by0nr7iD0WU2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3859
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10107 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109150090
X-Proofpoint-ORIG-GUID: 97y00Ehjvf7S9C8ePEHMRdvml_JJEo6E
X-Proofpoint-GUID: 97y00Ehjvf7S9C8ePEHMRdvml_JJEo6E
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Sep 14, 2021, at 12:48 PM, Chuck Lever III <chuck.lever@oracle.com> wr=
ote:
>=20
>=20
>=20
>> On Sep 14, 2021, at 12:37 PM, Bruce Fields <bfields@fieldses.org> wrote:
>>=20
>> From: "J. Bruce Fields" <bfields@redhat.com>
>> Subject: [PATCH] nfsd: don't alloc under spinlock in rpc_parse_scope_id
>>=20
>> Dan Carpenter says:
>>=20
>> The patch d20c11d86d8f: "nfsd: Protect session creation and client
>> confirm using client_lock" from Jul 30, 2014, leads to the following
>> Smatch static checker warning:
>>=20
>>       net/sunrpc/addr.c:178 rpc_parse_scope_id()
>>       warn: sleeping in atomic context
>>=20
>> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
>> Fixes: d20c11d86d8f ("nfsd: Protect session creation and client...")
>> Signed-off-by: J. Bruce Fields <bfields@redhat.com>
>> ---
>>=20
>> net/sunrpc/addr.c | 40 ++++++++++++++++++----------------------
>> 1 file changed, 18 insertions(+), 22 deletions(-)
>>=20
>> On Thu, Sep 09, 2021 at 10:56:33AM -0400, Jeff Layton wrote:
>>> Hmm, it sounds line in the second email he suggests using memcpy():
>>>=20
>>> "Your "memcpy()" example implies that the source is always a fixed-size
>>> thing. In that case, maybe that's the rigth thing to do, and you
>>> should just create a real function for it."
>>>=20
>>> Maybe I'm missing the context though.
>=20
> The scope identifier isn't fixed in size, so I'm not sure how you
> got there.
>=20
>=20
>>> In any case, when you're certain about the length of the source and
>>> destination buffers, there's no real benefit to avoiding memcpy in favo=
r
>>> of strcpy and the like. It's just as correct.
>>=20
>> OK, queueing this up as is for 5.16 unless someone objects.
>=20
> IMO Linus prefers strscpy() over open-coded memcpys, but it's not
> a hill I'm going to fight and die on.
>=20
>=20
>> (But, could
>> really use testing, I'm not currently testing over ipv6.)--b.
>=20
> Seems like you could generate some artificial test cases without
> needing to set up IPv6.

Actually, a scope ID is needed when using link-local addresses,
which are set up automatically simply when IPv6 is enabled.
If you see an address like this:

    inet6 fe80::2eae:686b:8c82:fad2/64 scope link noprefixroute=20
       valid_lft forever preferred_lft forever

Then you can use this address to mount with by adding that
interface name as the scope ID.


>> diff --git a/net/sunrpc/addr.c b/net/sunrpc/addr.c
>> index 6e4dbd577a39..d435bffc6199 100644
>> --- a/net/sunrpc/addr.c
>> +++ b/net/sunrpc/addr.c
>> @@ -162,8 +162,10 @@ static int rpc_parse_scope_id(struct net *net, cons=
t char *buf,
>> 			      const size_t buflen, const char *delim,
>> 			      struct sockaddr_in6 *sin6)
>> {
>> -	char *p;
>> +	char p[IPV6_SCOPE_ID_LEN + 1];
>> 	size_t len;
>> +	u32 scope_id =3D 0;
>> +	struct net_device *dev;
>>=20
>> 	if ((buf + buflen) =3D=3D delim)
>> 		return 1;
>> @@ -175,29 +177,23 @@ static int rpc_parse_scope_id(struct net *net, con=
st char *buf,
>> 		return 0;
>>=20
>> 	len =3D (buf + buflen) - delim - 1;
>> -	p =3D kmemdup_nul(delim + 1, len, GFP_KERNEL);
>> -	if (p) {
>> -		u32 scope_id =3D 0;
>> -		struct net_device *dev;
>> -
>> -		dev =3D dev_get_by_name(net, p);
>> -		if (dev !=3D NULL) {
>> -			scope_id =3D dev->ifindex;
>> -			dev_put(dev);
>> -		} else {
>> -			if (kstrtou32(p, 10, &scope_id) !=3D 0) {
>> -				kfree(p);
>> -				return 0;
>> -			}
>> -		}
>> -
>> -		kfree(p);
>> -
>> -		sin6->sin6_scope_id =3D scope_id;
>> -		return 1;
>> +	if (len > IPV6_SCOPE_ID_LEN)
>> +		return 0;
>> +
>> +	memcpy(p, delim + 1, len);
>> +	p[len] =3D 0;
>> +
>> +	dev =3D dev_get_by_name(net, p);
>> +	if (dev !=3D NULL) {
>> +		scope_id =3D dev->ifindex;
>> +		dev_put(dev);
>> +	} else {
>> +		if (kstrtou32(p, 10, &scope_id) !=3D 0)
>> +			return 0;
>> 	}
>>=20
>> -	return 0;
>> +	sin6->sin6_scope_id =3D scope_id;
>> +	return 1;
>> }
>>=20
>> static size_t rpc_pton6(struct net *net, const char *buf, const size_t b=
uflen,
>> --=20
>> 2.31.1
>>=20
>=20
> --
> Chuck Lever

--
Chuck Lever



