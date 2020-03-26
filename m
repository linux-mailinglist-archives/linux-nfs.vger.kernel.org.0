Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F70E194B88
	for <lists+linux-nfs@lfdr.de>; Thu, 26 Mar 2020 23:29:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgCZW3v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 26 Mar 2020 18:29:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55132 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgCZW3v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 26 Mar 2020 18:29:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QMSYv0178468;
        Thu, 26 Mar 2020 22:29:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=AbnF9vL8V5KcErLA/dx3AbUSHBS3ZjKSUCbowOPIxBQ=;
 b=OSvQga1K+wfyGCM+thkdl6gQ6QHkKbTxVPkn1eo+KofzPr8bhKUaE0P5mNGwqS3jlmpG
 hGyCiDR24GbFuCl2ewyo6tbQWcqt7JWvgMd4PKVcMotgJkoCj2OfA/eCahe9eKlxf/Y9
 D2+Ef3FfxMq5mksmKSSFXLsR0bQ6iGfDCPeBrw9b711H9cyvudTplqHybroFSEm9wd4c
 GzdcA946rESJE5punlDl6SiojrvVtOwaau6kxSITrU3yf8bZidQqJF8eC7rbBDJvRxSr
 chfIFIxIrL8WwzcvS1/vhqUhsJmNC1JYxCY0Jc6krGCC8b0XXPNeVw9zFtqZNQnDVeY7 xw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 300urk36pt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 22:29:44 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02QMQb85133092;
        Thu, 26 Mar 2020 22:29:44 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 30073epnya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Mar 2020 22:29:44 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 02QMThpU029885;
        Thu, 26 Mar 2020 22:29:43 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 26 Mar 2020 15:29:43 -0700
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 2/2] SUNRPC: Optimize 'svc_print_xprts()'
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <87r1xe7pvy.fsf@notabene.neil.brown.name>
Date:   Thu, 26 Mar 2020 18:29:41 -0400
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AC34F25-68B7-4184-9A91-A6D026F6BA6F@oracle.com>
References: <20200325070452.22043-1-christophe.jaillet@wanadoo.fr>
 <EA5BCDB2-DB05-4B26-8635-E6F5C231DDC6@oracle.com>
 <42afbf1f-19e1-a05c-e70c-1d46eaba3a71@wanadoo.fr>
 <87wo786o80.fsf@notabene.neil.brown.name>
 <2e2d1293-c978-3f1d-5a1e-dc43dc2ad06b@wanadoo.fr>
 <87r1xe7pvy.fsf@notabene.neil.brown.name>
To:     Neil Brown <neilb@suse.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=988 adultscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003260163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9572 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 mlxlogscore=999 clxscore=1015 lowpriorityscore=0 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2003260163
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Mar 26, 2020, at 5:44 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Thu, Mar 26 2020, Christophe JAILLET wrote:
>=20
>> Le 25/03/2020 =C3=A0 23:53, NeilBrown a =C3=A9crit :
>>> Can I suggest something more like this:
>>> diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
>>> index de3c077733a7..0292f45b70f6 100644
>>> --- a/net/sunrpc/svc_xprt.c
>>> +++ b/net/sunrpc/svc_xprt.c
>>> @@ -115,16 +115,9 @@ int svc_print_xprts(char *buf, int maxlen)
>>>  	buf[0] =3D '\0';
>>>=20
>>>  	spin_lock(&svc_xprt_class_lock);
>>> -	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list) {
>>> -		int slen;
>>> -
>>> -		sprintf(tmpstr, "%s %d\n", xcl->xcl_name, =
xcl->xcl_max_payload);
>>> -		slen =3D strlen(tmpstr);
>>> -		if (len + slen > maxlen)
>>> -			break;
>>> -		len +=3D slen;
>>> -		strcat(buf, tmpstr);
>>> -	}
>>> +	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list)
>>> +		len +=3D scnprintf(buf + len, maxlen - len, "%s %d\n",
>>> +				 xcl->xcl_name, xcl->xcl_max_payload);
>>>  	spin_unlock(&svc_xprt_class_lock);
>>>=20
>>>  	return len;
>>>=20
>>> NeilBrown
>>=20
>> Hi,
>>=20
>> this was what I suggested in the patch:
>>     ---
>>     This patch should have no functional change.
>>     We could go further, use scnprintf and write directly in the=20
>> destination
>>     buffer. However, this could lead to a truncated last line.
>>     ---
>=20
> Sorry - I missed that.
> So add
>=20
> end =3D strrchr(tmpstr, '\n');
> if (end)
>    end[1] =3D 0;
> else
>    tmpstr[0] =3D 0;
>=20
> or maybe something like
> 	list_for_each_entry(xcl, &svc_xprt_class_list, xcl_list) {
> 		int l =3D snprintf(buf + len, maxlen - len, "%s %d\n",
> 				 xcl->xcl_name, xcl->xcl_max_payload);
>                if (l < maxlen - len)
>                	len +=3D l;
>        }
>        buf[len] =3D 0;
>=20
> There really is no need to have the secondary buffer, and I think =
doing
> so just complicates the code.

In the interest of getting this fix into the upcoming merge window, =
let's
stick with the temporary buffer approach. Thanks!


--
Chuck Lever



